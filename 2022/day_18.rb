class Solution < AbstractSolution
  def parse
    @cubes = @data.split("\n").map{|r| r.split(",").map(&:to_i)}
    @space = Set.new
    @cubes.each do |c|
      @space.add(c)
    end
  end

  def peers(c)
    [
      [-1, 0, 0],
      [ 0, 1, 0],
      [ 0,-1, 0],
      [ 0, 0, 1],
      [ 0, 0,-1],
      [ 1, 0, 0]
    ].map do |p|
      pc = c.zip(p).map(&:sum)
      @space.include?(pc) ? pc : nil
    end.compact
  end

  def part1
    parse
    @cubes.sum do |c|
      6 - peers(c).count
    end
  end

  def part2
    # parse
  end
end
