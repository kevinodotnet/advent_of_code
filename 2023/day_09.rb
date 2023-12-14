class Solution < AbstractSolution
  def parse
    @histories = @data.split("\n").map do |l|
      l.scan(/[\d-]+/).map{|d| d.to_i}
    end
  end

  def part1
    parse.map{|h| [h]}.map do |h|
      while h.last.uniq != [0] do
        last_h = h.last
        new_h = last_h.each_with_index.map do |v, i|
          next if i == 0
          last_h[i] - last_h[i-1]
        end.compact
        h << new_h
      end
      h.map{|l| l.last}.sum
    end.sum
  end

  def part2
    parse
  end
end
