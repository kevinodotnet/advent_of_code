class Solution < AbstractSolution
  def number_at(y, x)
    f = 0
    b = 0
    line = @data[y]
    loop do
      if line[x-(b+1)].match(/\d/)
        b += 1
        next
      end
      if line[x+(f+1)].present? && line[x+(f+1)].match(/\d/)
        f += 1
        next
      end
      break
    end
    {
      y: y,
      x: (x-b),
      n: line[(x-b)..(x+f)].join("").to_i
    }
  end

  def peers(y, x)
    r = [-1, 0, 1].map do |dy|
      ay = y + dy
      next if ay < 0
      next if ay == @data.length
      [-1, 0, 1].map do |dx|
        ax = x + dx
        next if dx == 0 && dy == 0
        next if ax < 0
        next if ax == @data[ay].length
        {
          y: ay,
          x: ax,
          c: @data[ay][ax]
        }
      end
    end.flatten.compact
    r
  end

  def parse
    @data = @data.split("\n").map do |l|
      l.split("")
    end
  end

  def part1
    parse
    parts = []
    @data.each_with_index do |r, y|
      r.each_with_index do |c, x|
        next if c.match?(/\d/) || c == "."
        parts << peers(y, x).select{|p| p[:c].match?(/\d/)}.map{|p| number_at(p[:y], p[:x])}
      end
    end
    parts.flatten.uniq.sum{|p| p[:n]}
  end

  def part2
    parse
  end
end
