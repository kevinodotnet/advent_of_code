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
      visited.add({
        pos: pos,
        dir: DIRS[dir]
      })

      break if board_peek(board: board, pos: pos, dir: dir).nil?

      if board_peek(board: board, pos: pos, dir: dir) == "#"
        dir = (dir + 1) % DIRS.length
        board[pos[0]][pos[1]] = "@"
      else
        pos = position_peek(board: board, pos: pos, dir: dir)
        board[pos[0]][pos[1]] = "X"
      end
    end
    visited
  end

  def part1
    explore(board: @data, pos: @pos, dir: @dir).to_a.map{|v| v[:pos]}.uniq.count
  end

  def part2
  end
end
