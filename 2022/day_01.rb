class Solution < AbstractSolution
  def parse
    @data.split("\n\n").map{|e| e.split("\n").map{|i| i.to_i}}
  end

  def part1
    parse.map{|e| e.sum}.max
  end

  def part2
  end
end
