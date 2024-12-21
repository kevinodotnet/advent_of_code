class Solution < AbstractSolution
  DIRS = {
    "^" => [-1, 0],
    "v" => [1, 0],
    "<" => [0, -1],
    ">" => [0, 1]
  }

  def print_board(pry_if_broken = true)
    pry_if_broken = false
    puts @board.map{|r| r.join("")}.join("\n")
    @board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        other = nil
        if cell == '['
          binding.pry if row[x+1] != ']' && pry_if_broken
        end
        if cell == ']'
          binding.pry if row[x-1] != '[' && pry_if_broken
        end
      end
    end
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

  def can_shift(pos, m)
    spot = @board[pos[0]][pos[1]]
    return false if spot == '#'
    return true if spot == '.'

    dir = DIRS[m]

    if %w(< >).include?(m)
      new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
      return can_shift(new_pos, m)
    end

    if spot == ']'
      # recurse on left-side boxes first
      other_box_side_pos = [pos[0], pos[1]-1]
      return can_shift(other_box_side_pos, m)
    end

    if spot == '['
      new_pos1 = [pos[0] + dir[0], pos[1] + dir[1]]
      new_pos2 = [pos[0] + dir[0], pos[1] + dir[1] + 1]
      return can_shift(new_pos1, m) && can_shift(new_pos2, m)
    end

    # recurse on left-side boxes first
    if %w(^ v).include?(m) && spot == ']'
      other_box_side_pos = [pos[0], pos[1]-1]
      return false unless can_shift(other_box_side_pos, m)
    end

    new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    can_shift(new_pos, m)
  end

  def shift(pos, m, moving)
    spot = @board[pos[0]][pos[1]]

    dir = DIRS[m]
    new_pos = [pos[0] + dir[0], pos[1] + dir[1]]

    if %w(< >).include?(m)
      # simple left/right move
      if spot == '.'
        @board[pos[0]][pos[1]] = moving
        return
      end
  
      shift(new_pos, m, spot)
      @board[pos[0]][pos[1]] = moving
      return
    end

    # moving up or down

    if %w([ ]).include?(spot)
      pos2 = [pos[0], pos[1] + (spot == '[' ? 1 : -1)]
      spot2 = @board[pos2[0]][pos2[1]]
      new_pos2 = [pos2[0] + dir[0], pos2[1] + dir[1]]
      shift(new_pos, m, spot)
      shift(new_pos2, m, spot2)
      @board[pos[0]][pos[1]] = moving
      @board[pos2[0]][pos2[1]] = '.'
      return
    end

    shift(new_pos, m, spot) if spot != '.'
    @board[pos[0]][pos[1]] = moving
  end

  def solve
    @moves.each_with_index do |m, i|
      dir = DIRS[m]
      next if m == "\n"
      next unless can_shift(@robot, m)
      shift(@robot, m, '.')
      @robot = [@robot[0] + dir[0], @robot[1] + dir[1]]
    end

    boxes = %w(O [)

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
        case row[i]
        when "#"
          #row[i] = "#"
          row.insert(i+1, "#")
        when "O"
          row[i] = "["
          row.insert(i+1, "]")
        when "."
          #row[i] = "."
          row.insert(i+1, ".")
        when "@"
          #row[i] = "@"
          row.insert(i+1, ".")
        end
        if @robot[0] == y && @robot[1] > i
          @robot[1] += 1
        end
        i += 2
      end
    end
    solve
  end
end
