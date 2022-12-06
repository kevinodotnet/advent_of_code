class Solution < AbstractSolution
  def parse
    @data.split("")
  end

  def scan_marker(range)
    chars = parse
    chars.each_with_index do |v, i|
      next if i < range
      next if chars[(i-range)..(i-1)].uniq.count < range
      return i
    end
    nil
  end

  def part1
    scan_marker(4)
  end

  def part2
    scan_marker(14)
  end
end
