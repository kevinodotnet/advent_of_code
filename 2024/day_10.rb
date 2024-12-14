class Solution < AbstractSolution
  DIRS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]

  def parse
    @data = @data.split("\n").map{|l| l.split("").map{|c| c == '.' ? '.' : c.to_i}}
    @trailheads = {}
    @summits = []
    @data.map.with_index do |row, y|
      row.map.with_index do |cell, x|
        next unless cell == 9
        @summits << [y, x]
      end
    end
  end

  def print_scores
    puts @scores.map{|l| l.map{|v| v.nil? ? '.' : v}.join("")}.join("\n")
  end

  def print_data
    puts @data.map{|l| l.join("")}.join("\n")
  end

  def peers(p)
    DIRS.map do |dir|
      peer = [p[0] + dir[0], p[1] + dir[1]]
      next if peer[0] < 0 || peer[0] >= @data.length
      next if peer[1] < 0 || peer[1] >= @data[0].length
      peer
    end.compact
  end

  def search_for_trailheads(s, p, path)
    height = @data[p[0]][p[1]]

    if height == 0
      # summit s can be reached from this trailhead
      @trailheads[p] ||= {
        summits: Set.new,
        paths: Set.new
      }
      @trailheads[p][:summits] << s
      @trailheads[p][:paths] << path
      return 1 # trailheads reach only self
    end

    peers(p).each do |peer|
      next unless @data[peer[0]][peer[1]] == height - 1
      search_for_trailheads(s, peer, [*path, peer])
    end
  end

  def part1
    @summits.each do |s|
      search_for_trailheads(s, s, [s])
    end
    @trailheads.map do |k, v|
      v[:summits].count
    end.sum
  end

  def part2
    @summits.each do |s|
      search_for_trailheads(s, s, [s])
    end
    @trailheads.map do |k, v|
      v[:paths].count
    end.sum
  end
end
