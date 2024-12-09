class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|r| r.split("")}
    @antennas = @data.each_with_index.map do |r, y|
      r.each_with_index.map do |f, x|
        {
          f: f,
          y: y,
          x: x
        } unless f == '.'
      end
    end.flatten.compact
  end

  def pos_peek(y:, x:, dir:, dis:)
    y1 = y + dir[0] * dis
    x1 = x + dir[1] * dis
    return nil if y1 < 0 || x1 < 0
    return nil if y1 >= @data.length || x1 >= @data[0].length
    {
      y: y1,
      x: x1,
    }
  end

  def board_peek(y:, x:)
    return nil if y < 0 || x < 0
    return nil if y >= @data.length || x >= @data[0].length
    @data[y][x]
  end

  def print_board
    puts [" ", @data.first.length.times.map{|i| i % 10}.join("")].join("")
    @data.each_with_index.map do |r, i| 
      puts [i % 10, " ", r.join("")].join("")
    end
    nil
  end

  def part1
    antinodes = Set.new
    @antennas.map{|a| a[:f]}.uniq.each do |f|
      same_f = @antennas.select{|a| a[:f] == f}
      same_f.each_with_index do |a, i|
        others = same_f[i+1..]
        others.each do |o|
          dis = {
            y: o[:y] - a[:y],
            x: o[:x] - a[:x]
          }
          a1 = {
            f: a[:f],
            y: o[:y] + dis[:y],
            x: o[:x] + dis[:x]
          }
          a2 = {
            f: a[:f],
            y: a[:y] + dis[:y] * -1,
            x: a[:x] + dis[:x] * -1
          }
          [a1, a2].each do |a|
            v = board_peek(y: a[:y], x: a[:x])
            antinodes << a if v
          end
        end
      end
    end
    antinodes.map{|a| a.except(:f)}.uniq.count
  end

  def part2
  end
end
