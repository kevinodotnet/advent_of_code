class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.split("")}
  end

  def part1
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    result = []

    @data.count.times do |y|
      @data[y].count.times do |x|
        next unless @data[y][x] == "X"
        directions.each do |d|
          word = 4.times.map do |i|
            y1 = y + d[0] * i
            x1 = x + d[1] * i
            next if x1 < 0 || y1 < 0
            @data[y1][x1] if @data[y1] && @data[y1][x1]
          end
          result << {
            y: y,
            x: x,
            d: d
          } if word.join("") == "XMAS"
        end
      end
    end
    result.count
  end

  def part2
  end
end
