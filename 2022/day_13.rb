class Solution < AbstractSolution
  def parse
    @data.split("\n\n").map do |l|
      l.split("\n").map do |c|
        JSON.parse(c)
      end
    end
  end

  def compare(left, right)
    if left.is_a?(Array) && right.is_a?(Array)
      [left.count, right.count].max.times do |i|
        return 1 if left[i].nil?
        return -1 if right[i].nil?
        result = compare(left[i], right[i])
        return result unless result == 0
      end
    elsif left.is_a?(Integer) && right.is_a?(Integer)
      return 1 if left < right
      return -1 if left > right
      return 0
    else
      left = [left] if left.is_a?(Integer)
      right = [right] if right.is_a?(Integer)
      return compare(left, right)
    end
    0
  end

  def part1
    results = parse.map { |pair| compare(pair[0], pair[1]) }
    results.map.with_index{|r, i| r == 1 ? i+1 : nil}.compact.sum
  end

  def part2
    packets = []
    packets << [[2]]
    packets << [[6]]
    parse.each do |p|
      packets << p[0]
      packets << p[1]
    end
    sorted_packets = packets.sort{|a, b| compare(b, a)}
    (sorted_packets.find_index([[2]]) + 1) * (sorted_packets.find_index([[6]]) + 1)
  end
end
