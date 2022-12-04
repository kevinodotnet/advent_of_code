class Solution < AbstractSolution
  def parse
    @data.split("\n").map do |pairs|
      pairs.split(",").map{|r| r.split("-").map(&:to_i)}.map{|r| r[0]..r[1]}
    end
  end

  def part1
    parse.select{|p1, p2| p1.cover?(p2) || p2.cover?(p1) }.count
  end

  def part2
    # parse
  end
end
