class Solution < AbstractSolution
  def parse
  end

  def part1
    @muls = @data.scan(/mul\(\d+,\d+\)/)
    @pairs = @muls.map{|o| o.scan(/\d+/).map(&:to_i)}
    @pairs.map { |a, b| a * b }.sum
  end

  def part2
    doit = true
    result = 0
    @data.scan(/mul\(\d+,\d+\)|do\(\)|don't\(\)/).each do |o|
      if o.match(/mul/)
        a, b = o.scan(/\d+/).map(&:to_i)
        result += a * b if doit
      else
        doit = o.match(/do\(\)/)
      end
    end
    result
  end
end
