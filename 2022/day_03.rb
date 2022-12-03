class Sack
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.priority(item)
    priorities = {}
    (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |c, i|
      priorities[c] = i+1
    end
    priorities[item]
  end

  def common_priority
    c1 = @items[0..(@items.length/2-1)].split("")
    c2 = @items[(@items.length/2)..].split("")
    common = (c1 & c2).first
    Sack.priority(common)
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
    sacks = parse
    sacks.each_slice(3).map do |group|
      Sack.priority(group.map{|s| s.items.split("")}.inject(&:&).first)
    end.sum
  end
end
