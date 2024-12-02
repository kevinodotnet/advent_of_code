class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.split(" ").map(&:to_i)}
  end

  def part1
    samples = @data.map do |r|
      distances = r.each_cons(2).map{|a, b| (b-a)}
      distances.max.abs <= 3
      pos_count = distances.count { |distance| distance.positive? }
      {
        under_limit: distances.map(&:abs).max <= 3,
        same_sign: (pos_count == 0 || pos_count == distances.count),
        no_zeros: distances.count(0) == 0
      }
    end
    samples.map{|s| s.values.all?(true)}.count(true)
  end

  def part2
  end
end
