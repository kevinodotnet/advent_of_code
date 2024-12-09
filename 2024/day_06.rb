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

  def position_peek(board:, pos:, dir:)
    next_pos = pos.map.with_index{|p, i| p + DIRS[dir][i]}
    return nil if next_pos[0] < 0 || next_pos[1] < 0
    return nil if next_pos[0] >= board.length || next_pos[1] >= board[0].length
    next_pos
  end

  def board_peek(board:, pos:, dir:)
    new_pos = position_peek(board: board, pos: pos, dir: dir)
    return nil if new_pos.nil?
    board[new_pos[0]][new_pos[1]]
  end

  def explore(board:, pos:, dir:)
    visited = Set.new
    loop do
      pos_dir = {
        pos: pos,
        dir: DIRS[dir],
        diri: dir
      }
      return { result: :loops, visited: visited } if visited.include?(pos_dir)
      visited << pos_dir

      break if board_peek(board: board, pos: pos, dir: dir).nil?

      bp = board_peek(board: board, pos: pos, dir: dir)

      if bp == "#"
        dir = (dir + 1) % DIRS.length
        board[pos[0]][pos[1]] = "@"
      else
        pos = position_peek(board: board, pos: pos, dir: dir)
        board[pos[0]][pos[1]] = "X"
      end
    end
    return { result: :exits, visited: visited }
  end

  def part1
    result = explore(board: @data, pos: @pos, dir: @dir)
    result[:visited].to_a.map{|v| v[:pos]}.uniq.count
  end

  def print_board(board)
    puts [" ", " ", board.first.length.times.map{|i| i}.join("")].join("")
    board.each_with_index.map do |r, i|
      puts [i, " ", r.join("")].join("")
    end
    nil
  end

  def part2
    board = @data.deep_dup
    result = explore(board: board, pos: @pos, dir: @dir)
    visited = result[:visited]

    tested = {}

    visited.each_with_index do |v, i|
      test_pos = position_peek(board: board, pos: v[:pos], dir: v[:diri])
      next if test_pos.nil?
      next if tested[test_pos]

      test_diri = (v[:diri] + 1) % DIRS.length

      prev_value = board[test_pos[0]][test_pos[1]]
      board[test_pos[0]][test_pos[1]] = "#"
      r2 = explore(board: board, pos: v[:pos], dir: test_diri)
      board[test_pos[0]][test_pos[1]] = prev_value

      tested[test_pos] = r2[:result]
    end
    tested.values.count(:loops)
  end
end
