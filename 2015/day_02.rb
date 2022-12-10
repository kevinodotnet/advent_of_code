class Solution < AbstractSolution
  def parse
    @data.split("\n").map{|l| l.split("x").map(&:to_i).sort}
  end

  def part1
    parse.map do |l,w,h|
      v = [l*w, w*h, h*l]
      (v.sum * 2) + v.min
    end.sum
  end

  def part2
    parse.map do |l,w,h|
      p = [l+w, w+h, h+l].min * 2
      v = l * w * h
      p + v
    end.sum
  end
end
