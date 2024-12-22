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
    if type == :left
      i -= 1
    elsif type == :right
      i += 1
    end
    i = i % DIRS.length
    d = DIRS.values[i]
    pos = prev_move[:pos]
    new_pos = pos[0] + d[0], pos[1] + d[1]
    next_move = {
      id: @id += 1,
      char: @data[new_pos[0]][new_pos[1]],
      pos: new_pos,
      type: type,
      dir: DIRS.keys[i],
      score: 1 + (type == :forward ? 0 : 1000),
    }
    next_move[:running] = prev_move[:running] + next_move[:score]
    next_move
  end

  def valid_moves(prev_move)
    moves = []
    moves << next_move(prev_move, :left)
    moves << next_move(prev_move, :right)
    moves << next_move(prev_move, :forward)
    moves.select{|m| m[:char] == 'E' || m[:char] == '.'}
  end

  def solve
    pos = @start
    dir = @dir

    @id = 0

    move = {
      id: @id += 1,
      char: @data[pos[0]][pos[1]],
      pos: pos,
      type: :start,
      dir: dir,
      score: 0,
      running: 0
    }

    moves = [[move]]

    aborted = 0

    while moves.any?
      tip = moves.sort_by{|m| m.last[:running]}.first
      @points[tip.last[:pos]] ||= tip.last
      if @points[tip.last[:pos]][:running] < tip.last[:running]
        moves.delete(tip)
        next
      end
      valid_moves(tip.last).each do |m|
        if @points[m[:pos]]
          if m[:running] >= @points[m[:pos]][:running]
            next
          end
        end
        @points[m[:pos]] = m
        if m[:char] == 'E'
          return m[:running]
        end
        moves << tip.dup + [m]
      end
      moves.delete(tip)
    end
    binding.pry
  end

  def part1
    solve
  end

  def part2
    solve
  end
end
