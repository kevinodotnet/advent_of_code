class Solution < AbstractSolution
  def parse
    @data.split("\n").map do |l|
      digits = l.gsub(/[^0-9]/, '')
      [
        digits.first,
        digits.last
      ].join("").to_i
    end
  end

  def part1
    parse.sum
  end

  def part2
    parse
  end
end
