class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.split("")}
  end

  def findword(search_word)
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    result = []

    @data.count.times do |y|
      @data[y].count.times do |x|
        next unless @data[y][x] == search_word[0]
        directions.each do |d|
          word = search_word.length.times.map do |i|
            y1 = y + d[0] * i
            x1 = x + d[1] * i
            next if x1 < 0 || y1 < 0
            @data[y1][x1] if @data[y1] && @data[y1][x1]
          end
          result << {
            y: y,
            x: x,
            d: d
          } if word.join("") == search_word
        end
      end
    end
    result
  end

  def part1
    findword("XMAS").count
  end

  def diagonal?(d1, d2)
    d1_diag = d1.count(0) == 0
    d2_diag = d2.count(0) == 0
    d1_diag && d1_diag == d2_diag
  end

  def part2
    results = findword("MAS")

    results.each do |r|
      r[:ay] = r[:y] + r[:d][0]
      r[:ax] = r[:x] + r[:d][1]
    end

    pairs = Set.new
    results.each_with_index do |r, i|
      results[i+1..].select{|r1| r1[:ay] == r[:ay] && r1[:ax] == r[:ax]}.each do |r1|
        next unless diagonal?(r[:d], r1[:d])
        pairs << [r, r1]
      end
    end
    pairs.count
  end
end
