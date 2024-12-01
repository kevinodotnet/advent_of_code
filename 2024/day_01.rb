class Solution < AbstractSolution
  def parse
    @data = @data.split(/\n/).map{|l| l.split(/ +/).map(&:to_i)}
    @lists = []
    @lists << @data.map{|l| l[0]}.sort
    @lists << @data.map{|l| l[1]}.sort
  end

  def part1
    distances = @lists[0].each_with_index.map do |_v, i|
      pair = @lists.map{|l| l[i]}.sort
      pair[1] - pair[0]
    end
    distances.sum
  end

  def part2
    left = @lists[0]
    right = @lists[1]
    score = left.map do |l|
      l * right.count{|v| v == l}
    end
    score.sum
  end
end
