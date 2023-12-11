class Solution < AbstractSolution
  def parse
    @data = @data.split("\n")
    @steps = @data.shift.split("").map{|s| s.to_sym}
    @data.shift
    @nodes = {}
    @data.each do |l|
      _, from, left, right = l.match(/^(.*) = \((.*), (.*)\)/).to_a
      @nodes[from.to_sym] = {
        L: left.to_sym,
        R: right.to_sym
      }
    end
  end

  def part1
    parse
    loc = :AAA
    count = 0
    loop do
      @steps.each do |s|
        count += 1
        loc = @nodes[loc][s]
        return count if loc == :ZZZ
      end
    end
    binding.pry # bad
  end

  def part2
    parse
  end
end
