class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.split(" ").map(&:to_i)}
  end

  def analyze(r)
    distances = r.each_cons(2).map{|a, b| (b-a)}
    return false unless distances.map(&:abs).max <= 3

    pos_count = distances.count { |distance| distance.positive? }
    return false unless (pos_count == 0 || pos_count == distances.count)

    return false unless distances.count(0) == 0
    true
  end

  def part1
    @data.map do |r|
      analyze(r)
    end.count(true)
  end

  def part2
    @data.map do |r|
      if analyze(r)
        true
      else
        result = (r.count).times.map do |i|
          new_r = r[0...i] + r[i+1..-1]
          analyze(new_r)
        end
        result.count(true) > 0
      end
    end.count(true)
  end
end
