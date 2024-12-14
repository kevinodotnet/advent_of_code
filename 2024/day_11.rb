class Solution < AbstractSolution
  def parse
    @data = @data.scan(/\d+/).map(&:to_i)
    @stones = {
      :zero => {},
      :even => {},
      :other => {},
    }
    @data.each do |v|
      @stones[type(v)][v] ||= 0
      @stones[type(v)][v] += 1
    end
  end

  def type(v)
    return :zero if v == 0
    return :even if v.to_s.length.even?
    :other
  end

  def blink
    new_stones = {
      :zero => {},
      :even => {},
      :other => {},
    }

    new_stones[:other][1] = @stones[:zero][0] || 0

    @stones[:even].each do |i, count|
      s = i.to_s
      left = s[0..s.length/2-1].to_i
      right = s[s.length/2..-1].to_i

      new_stones[type(left)][left] ||= 0
      new_stones[type(left)][left] += count
      new_stones[type(right)][right] ||= 0
      new_stones[type(right)][right] += count
    end

    @stones[:other].each do |i, count|
      v = i * 2024
      new_stones[type(v)][v] ||= 0
      new_stones[type(v)][v] += count
    end

    @stones = new_stones
  end

  def solve(blinks)
    blinks.times { blink }
    @stones.map { |k, v| v.values.sum }.sum
  end
end
