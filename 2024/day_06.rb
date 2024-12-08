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
    visited_list = []
    loop do
      pos_dir = {
        pos: pos,
        dir: DIRS[dir],
        diri: dir
      }
      return { result: :loops, visited: visited, visited_list: visited_list } if visited.include?(pos_dir)
      visited << pos_dir
      visited_list << pos_dir

      break if board_peek(board: board, pos: pos, dir: dir).nil?

      bp = board_peek(board: board, pos: pos, dir: dir)

      if bp == "#" || bp == "!"
        dir = (dir + 1) % DIRS.length
        board[pos[0]][pos[1]] = "@"
      else
        pos = position_peek(board: board, pos: pos, dir: dir)
        board[pos[0]][pos[1]] = "X"
      end
    end
    return { result: :exits, visited: visited, visited_list: visited_list }
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
    visited_list = result[:visited_list]

    tested = {}

    board2 = @data.deep_dup
    last_iteration_debug = ''
    visited_list.each_with_index do |v, i|
      print last_iteration_debug
      puts " #{i}/#{visited_list.count}" if i % 50 == 0
      test_board = board2.deep_dup
      test_pos = position_peek(board: test_board, pos: v[:pos], dir: v[:diri])
      next if test_pos.nil?
      if tested[test_pos]
        # binding.pry
        last_iteration_debug = '.'
        next
      end

      #print_board(test_board)
      test_board[test_pos[0]][test_pos[1]] = "!"
      test_diri = (v[:diri] + 1) % DIRS.length
      # puts ""
      # print_board(test_board)

      r2 = explore(board: test_board, pos: v[:pos], dir: test_diri)

      tested[test_pos] = r2[:result]
      last_iteration_debug = (r2[:result] == :loops) ? 'l' : 'e'
      # puts "i: #{i} tested: #{tested[test_pos]}"


      # #print_board(test_board)
      # #puts "result: #{r2[:result]}"
      # # binding.pry

      # if r2[:result] == :loops
      #   puts "loop if placed at #{test_pos}"
      #   looping_locations << test_pos
      #   # binding.pry
      #   # binding.pry
      #   # looping_count += 1
      #   # puts ""
      #   # print_board(test_board)
      #   # puts "loops at #{v[:pos]} with dir #{v[:diri]}"
      #   # binding.pry
      # end
    end
    # binding.pry
    tested.values.count(:loops)
  end
end
