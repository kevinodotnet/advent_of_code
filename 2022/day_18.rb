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
    end
  end

  def part1
    parse
    @cubes.sum do |c|
      6 - peers(c).select{|pc| @space.include?(pc)}.count
    end
  end

  def air_pocket?(c)
    peers(c).count{|pc| @space.include?(pc)} == 6
  end

  def part2
    parse
    @cubes.sum do |c|
      # max
      area = 6
      # less sides adjacent to other droplets; or air pockets
      area -= peers(c).select{|pc| @space.include?(pc) || air_pocket?(pc)}.count
    end
  end
end
