class Solution < AbstractSolution
  def parse
    @data.split("\n\n").map do |l|
      l.split("\n").map do |c|
        eval(c)
      end
    end
  end

  def compare(left, right, indent = 0)
    if left.is_a?(Array) && right.is_a?(Array)
      [left.count, right.count].max.times do |i|
        return true if left[i].nil?
        return false if right[i].nil?
        result = compare(left[i], right[i])
        return result unless result.nil?
      end
    elsif left.is_a?(Integer) && right.is_a?(Integer)
      return true if left < right
      return false if left > right
      return nil
    else
      left = [left] if left.is_a?(Integer)
      right = [right] if right.is_a?(Integer)
      return compare(left, right)
    end
    nil
  end

  def part1
    results = parse.map { |pair| compare(pair[0], pair[1]) }
    results.map.with_index{|r, i| r ? i+1 : nil}.compact.sum
  end

  def part2
    # parse
  end
end
