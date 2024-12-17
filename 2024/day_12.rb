class Solution < AbstractSolution
  DIRS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]

  def peers(p)
    DIRS.map do |dir|
      peer = [p[0] + dir[0], p[1] + dir[1]]
      peer = nil if peer && (peer[0] < 0 || peer[0] >= @data.length)
      peer = nil if peer && (peer[1] < 0 || peer[1] >= @data[0].length)
      peer
    end
  end

  def parse
    @data = @data.split("\n").map{|l| l.split("")}
  end

  def print_data
    puts @data.map{|l| l.join("")}.join("\n")
  end

  def solve
    @crops = {}
    @points = {}

    # create crops, one per cell
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        c = {
          t: cell,
          p: Set.new
        }
        uuid = SecureRandom.uuid
        c[:p] << [y, x]
        @crops[uuid] = c
        @points[[y, x]] = uuid
      end
    end

    # merge cells of same crop, adjacent to each other
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        p = [y, x]
        peers(p).each do |peer|
          next if peer.nil?

          p_uuid = @points[p]
          p_crop = @crops[p_uuid]
          peer_uuid = @points[peer]
          peer_crop = @crops[peer_uuid]

          next if p_uuid == peer_uuid
          next unless p_crop[:t] == peer_crop[:t]

          p_crop[:p] += peer_crop[:p]
          peer_crop[:p].each do |point|
            @points[point] = p_uuid
          end
          @crops.delete(peer_uuid)
        end
      end
    end

    @crops.each do |uuid, c|
      c[:area] = c[:p].length
      c[:fences] = {}
      c[:p].each do |p|
        c[:fences][p] = {}
        DIRS.map do |dir|
          peer = [p[0] + dir[0], p[1] + dir[1]]
          fenced = if @points[peer].nil?
            true
          else
            @points[peer] != uuid
          end
          c[:fences][p][dir] = fenced
        end
      end
      c[:perimeter] = c[:fences].values.map{|f| f.values}.flatten.count(true)
      c[:cost] = c[:area] * c[:perimeter]
    end
  end

  def part1
    solve
    @crops.sum{|u, c| c[:cost]}
  end

  def part2
    solve

    binding.pry
    @crops.sum{|u, c| c[:cost]}
  end
end
