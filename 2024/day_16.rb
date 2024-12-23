class Solution < AbstractSolution
  DIRS = {
    "^" => [-1, 0],
    ">" => [0, 1],
    "v" => [1, 0],
    "<" => [0, -1]
  }

  def parse
    @data = @data.split("\n").map { |line| line.split('') }
    row, y = @data.each_with_index.detect{|r, i| r.include?("S")}
    _, x = row.each_with_index.detect{|c, i| c == "S"}
    @start = [y, x]
    row, y = @data.each_with_index.detect{|r, i| r.include?("E")}
    _, x = row.each_with_index.detect{|c, i| c == "E"}
    @end = [y, x]
    @dir = '>'
    @points = {}
  end

  def print_board
    puts @data.each_with_index.map{|r, y| [y < 10 ? "0#{y}" : y," ",r].flatten.join("")}.join("\n")
  end

  def next_move(prev_move, type)
    i = DIRS.keys.index(prev_move[:dir])
    d = DIRS.values[i]
    pos = prev_move[:pos]
    new_pos = pos[0] + d[0], pos[1] + d[1]
    if type == :forward
      next_char = @data[new_pos[0]][new_pos[1]]
      score = 1
    elsif type == :left
      i -= 1
      score = 1000
      next_char = @data[new_pos[0]][new_pos[1]]
      new_pos = pos
    elsif type == :right
      i += 1
      score = 1000
      next_char = @data[new_pos[0]][new_pos[1]]
      new_pos = pos
    end
    i = i % DIRS.length
    next_move = {
      char: next_char,
      pos: new_pos,
      type: type,
      dir: DIRS.keys[i],
      score: score,
    }
    next_move[:running] = prev_move[:running] + next_move[:score]
    next_move
  end

  def valid_moves(prev_move)
    forward = next_move(prev_move, :forward)
    left = next_move(prev_move, :left)
    left_forward = next_move(left, :forward)
    right = next_move(prev_move, :right)
    right_forward = next_move(right, :forward)

    moves = []
    moves << [forward] if forward[:char] != '#'
    moves << [left, left_forward] if left_forward[:char] != '#'
    moves << [right, right_forward] if right_forward[:char] != '#'
    moves
  end

  def print_board_with_moves(ms)
    board = @data.map(&:dup)
    ms.each do |m|
      board[m[:pos][0]][m[:pos][1]] = 'O'
    end
    puts board.each_with_index.map{|r, y| [y < 10 ? "0#{y}" : y," ",r].flatten.join("")}.join("\n")
  end

  def print_board_with_touched(touched, tip)
    board = @data.map(&:dup)
    touched.each do |ts|
      ts.each do |m|
        # binding.pry
        board[m[0]][m[1]] = 'O'
      end
    end
    board[tip[0]][tip[1]] = 'T'
    puts board.each_with_index.map{|r, y| [y < 10 ? "0#{y}" : y," ",r].flatten.join("")}.join("\n")
  end

  def print_moves(moves)
    mmm = moves.sort_by{|ms| ms.last[:running]}.map do |ms|
      ms = ms.deep_dup
      ms[0][:dir] = 'S'
      ms.map{|m| m[:dir]}.join("") + " #{ms.last[:running]}"
    end.join("\n")
    puts mmm
  end

  def solve
    pos = @start
    dir = @dir

    @id = 0

    move = {
      char: @data[pos[0]][pos[1]],
      pos: pos,
      type: :start,
      dir: dir,
      score: 0,
      running: 0
    }

    moves = [[move]]

    aborted = 0

    best_paths = []
    loops = 0

    while moves.any?
      tip = moves.sort_by{|m| m.last[:running]}.first
      puts "loops: #{loops += 1} moves: #{moves.count}"

      if loops % 5000 == 0
        all_touched = Set.new
        moves.each_with_index do |m, i|
          #puts "UNDERWAY: #{i}/#{moves.count} #{m.last[:pos]} #{m.last[:char]} #{m.last[:running]}"
          #print_board_with_moves(m)
          all_touched << m.map{|t| t[:pos]}
          # binding.pry if i >= 2
        end
        print_board_with_touched(all_touched, tip.last[:pos])
        puts "ALL moves: #{moves.count}"
        # puts ""
        # print_moves(moves)
        binding.pry
      end

      valid_moves(tip.last).each do |m|
        next if tip.any?{|m2| m2[:pos] == m.last[:pos]} # no loop in same path
        if best_paths.count > 0
          next if best_paths.last.last[:running] < m.last[:running]
        end

        if m.last[:char] == 'E'
          moves = moves.reject{|m2| m2.last[:running] > m.last[:running]}
          best_paths << tip.dup + m
          binding.pry
          next
        end
        moves << tip.dup + m
      end
      moves.delete(tip)
    end
    best_paths
  end

  def part1
    r = solve
    # binding.pry
    r.first.last[:running]
  end

  def part2
    r = solve
    r.flatten.map{|m| m[:pos]}.uniq.count
    # binding.pry
  end
end
