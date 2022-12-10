class Solution < AbstractSolution
  def parse
    @data.split("").map{|c| c == "(" ? 1 : -1}
  end

  def part1
    parse.sum
  end

  def part2
    # parse
  end
end
