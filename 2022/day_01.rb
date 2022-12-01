class Solution < AbstractSolution
  def parse
    @data.split("\n\n").map{|e| e.split("\n").map{|i| i.to_i}}.map{|e| e.sum}
  end

  def part1
    parse.max
  end

  def part2
    parse.sort.last(3).sum
  end
end
