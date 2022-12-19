class Solution < AbstractSolution
  def parse
    @map = {}
    @data.split("\n") do |l|
      m = l.match(/Valve (.*) has flow rate=(.*); tun.*valve[^ ]* (.*)/)
      name = m[1].to_sym
      rate = m[2].to_i
      leads = m[3].split(", ").map(&:to_sym)
      @map[name] = {
        name: name,
        rate: rate,
        leads: leads
      }
    end
    
    @good_valves = @map.select{|k, v| v[:rate] > 0}

    @graph = RGL::DirectedAdjacencyGraph.new
    @edge_weights = {}
    @map.each do |k, v| 
      v[:leads].each do |l| 
        @graph.add_edge(k, l)
        @edge_weights[[k, l]] = 1
      end
    end
    @dijkstra = RGL::DijkstraAlgorithm.new(@graph, @edge_weights, RGL::DijkstraVisitor.new(@graph))

    @any_any = {}
    @map.keys.each do |f|
      @map.keys.each do |t|
        @any_any[f] ||= {}
        @any_any[f][t] = @dijkstra.shortest_path(f, t).count # distance is get there + turn it on
      end
    end
  end

  def solve(pos:, prev:, step:, rate:, released:, unvisited:, visited:, frames:)
    released += ((@any_any[prev][pos]) * rate)
    rate += @map[pos][:rate]

    worthy = unvisited.select{|v| @any_any[pos][v] < step}
    if worthy.any?
      worthy.map do |v|
        solve(
          pos: v,
          prev: pos,
          step: step-@any_any[pos][v], 
          rate: rate,
          released: released,
          unvisited: unvisited.dup.delete(v),
          visited: visited.dup,
          frames: frames.dup
        )
      end.max
    else
      return released + (step * rate)
    end
  end

  def part1
    parse
    solve(pos: :AA, prev: :AA, step: 30, rate: 0, released: 0, unvisited: Set.new(@good_valves.keys), visited: [], frames: [])
  end

  def part2
    parse
    memo = Set.new
    r = @good_valves.keys.count.times.map { |i| @good_valves.keys.combination(i).to_a }.map do |c|
      c.map do |s|
        for_helper = Set.new(s)
        for_elf = Set.new(@good_valves.keys) - for_helper
        key = [
          for_elf.to_a.sort.join(","),
          for_helper.to_a.sort.join(","),
        ].sort.join("|")
        next if memo.include?(key)
        memo.add(key)
        elf_released = solve(pos: :AA, prev: :AA, step: 26, rate: 0, released: 0, unvisited: for_elf, visited: [], frames: [])
        helper_released = solve(pos: :AA, prev: :AA, step: 26, rate: 0, released: 0, unvisited: for_helper, visited: [], frames: [])
        elf_released + helper_released
      end
    end
    r.flatten.compact.max
  end
end
