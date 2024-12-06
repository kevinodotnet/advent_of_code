class Solution < AbstractSolution

  DIRS = [
    [-1, 0], # up,
    [0, 1], # left,
    [1, 0], # down,
    [0, -1] # right
  ]

  def parse
    @data = @data.split("\n").map{|s| s.split("")}
    @data.each_with_index do |y, i|
      y.each_with_index do |x, j|
        if x == "^"
          @pos = [i, j]
          @data[i][j] = "X"
        end
      end
    end
    @dir = 0 # DIRS[0] == up
    @visited = Set.new
  end

  def position_peek
    next_pos = @pos.map.with_index{|p, i| p + DIRS[@dir][i]}
    return nil if next_pos[0] < 0 || next_pos[1] < 0
    return nil if next_pos[0] >= @data.length || next_pos[1] >= @data[0].length
    next_pos
  end

  def board_peek
    return nil if position_peek.nil?
    @data[position_peek[0]][position_peek[1]]
  end

  def print_state
    puts "#" * 50
    puts "#" * 50
    puts "#" * 50
    puts ""
    puts @data.map{|d| d.join("")}.join("\n")
    puts ""
    puts "pos: #{@pos}"
    puts "dir: #{DIRS[@dir]}"
    puts "vis: #{@visited.count} u: #{@visited.to_a.map{|v| v[:pos]}.uniq.count}"
  end

  def part1
    loop do
      @visited.add({
        pos: @pos,
        dir: DIRS[@dir]
      })

      break if board_peek.nil?

      if board_peek == "#"
        @dir = (@dir + 1) % DIRS.length
        @data[@pos[0]][@pos[1]] = "@"
      else
        @pos = position_peek
        @data[@pos[0]][@pos[1]] = "X"
      end
    end
    @visited.to_a.map{|v| v[:pos]}.uniq.count
  end

  def part2
  end
end
