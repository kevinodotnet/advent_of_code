class Solution < AbstractSolution
  def parse
    @muls = @data.scan(/mul\(\d+,\d+\)/)
    @pairs = @muls.map{|o| o.scan(/\d+/).map(&:to_i)}
  end

  def part1
    @pairs.map { |a, b| a * b }.sum
  end

  def part2
  end
end
