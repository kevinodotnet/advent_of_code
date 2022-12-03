class Sack
  def initialize(items)
    @items = items
  end

  def common_priority
    @priorities = {}
    (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |c, i|
      @priorities[c] = i+1
    end
    c1 = @items[0..(@items.length/2-1)].split("")
    c2 = @items[(@items.length/2)..].split("")
    common = (c1 & c2).first
    @priorities[common]
  end
end

class Solution < AbstractSolution
  def parse
    @data.split("\n").map{ |items| Sack.new(items) }
  end

  def part1
    parse.sum(&:common_priority)
  end

  def part2
    # parse
  end
end
