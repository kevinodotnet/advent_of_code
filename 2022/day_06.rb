class Solution < AbstractSolution
  def parse
    @data.split("")
  end

  def part1
    chars = parse
    chars.each_with_index do |v, i|
      next if i < 4
      next if chars[(i-4)..(i-1)].uniq.count < 4
      return i
    end
    nil
  end

  def part2
    # parse
  end
end
