class Solution < AbstractSolution
  DIRS = {
    "^" => [-1, 0],
    "v" => [1, 0],
    "<" => [0, -1],
    ">" => [0, 1]
  }

  def print_board
    puts @board.map{|r| r.join("")}.join("\n")
  end

  def parse
    board, moves = @data.split("\n\n")
    @board = board.chomp.split("\n").map{|l| l.split("")}
    @moves = moves.chomp.split("")
    @robot = @board.each_with_index.map do |row, y|
      row.each_with_index.map do |cell, x|
        [y, x] if cell == "@"
      end
    end.select{|r| r.compact.any?}.first.compact.first
  end

  def robot_can_move(m)
    dir = DIRS[m]
    (1..).each do |steps|
      pos = [@robot[0] + dir[0] * steps, @robot[1] + dir[1] * steps]
      spot = @board[pos[0]][pos[1]]
      return true if spot == '.'
      return false if spot == '#'
    end
    # impossible
  end

  def solve
    @moves.each do |m|
      next if m == "\n"
      next unless robot_can_move(m)

      dir = DIRS[m]

      moving = '.' # move empty space into spot where robot is
      pos = @robot
      @robot = [pos[0] + dir[0], pos[1] + dir[1]]

      (0..).each do |s|
        next_moving = @board[pos[0]][pos[1]]

        @board[pos[0]][pos[1]] = moving
        moving = next_moving
        pos = [pos[0] + dir[0], pos[1] + dir[1]]
        break if moving == '.' # end at first space
      end
    end

    boxes = %w(O [ ])

    gps = @board.each_with_index.map do |row, y|
      row.each_with_index.map do |cell, x|
        next unless boxes.include?(cell)
        y*100 + x
      end
    end
    gps.flatten.compact.sum
  end

  def part1
    solve
  end

  def part2
    @board.each_with_index do |row, y|
      i = 0
      while i < row.length
        # If the tile is #, the new map contains ## instead.
        # If the tile is O, the new map contains [] instead.
        # If the tile is ., the new map contains .. instead.
        # If the tile is @, the new map contains @. instead.
        case row[i]
        when "#"
          #row[i] = "#"
          row.insert(i+1, "#")
        when "O"
          row[i] = "["
          row.insert(i+1, "]")
        when "."
          row[i] = "."
          row.insert(i+1, ".")
        when "@"
          row[i] = "@"
          row.insert(i+1, ".")
        end
        i += 2
      end
    end
    #solve
    print_board
  end
end