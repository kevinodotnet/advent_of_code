class Solution < AbstractSolution

  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.

  def parse
    @grid = @data.split("\n").map{|l| l.split("")}
    @start = @gr
    row, @start_y = @grid.each_with_index.detect{|v, i| v.include?("S") }
    @start_x = row.index("S")

    @steps = @grid.map do |y|
      y.map do |x|
        '.'
      end
    end

    @steps[@start_y][@start_x] = 0
  end

  def part1
    parse
    [
      [0, -1], # left
      [-1, 0], # up
      [0, 1],  # right
      [1, 0],  # down
    ].each do |dy, dx|
      binding.pry
    end
  end

  def part2
    parse
  end
end
