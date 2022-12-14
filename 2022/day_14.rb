require 'matrix'

class Solution < AbstractSolution
  def parse
    @board = {} # key: [y,x] tuple; value: occupied_by (string) or nil (empty)
    @data.split("\n").map do |l|
      l.split(" -> ").map{|p| p.split(",").map(&:to_i).reverse}
    end
  end

  def populate_board(lines, c = '#')
    lines.each do |l|
      l.each.with_index do |p_to, i|
        next if i == 0
        p_from = l[i-1]
        dy = (p_to[0] - p_from[0])
        dx = (p_to[1] - p_from[1])

        y_dir = dy < 0 ? -1 : 1
        x_dir = dx < 0 ? -1 : 1

        start_at = Matrix[l[i-1]]
        (dy.abs+1).times do |y|
          (dx.abs+1).times do |x|
            delta = Matrix[[y * y_dir,x * x_dir]]
            point = start_at + delta
            @board[point] = c
          end
        end
      end
    end
    @max_line_y = @board.keys.map{|m| m[0,0]}.max
  end

  def occupied
    @board.select{|k, v| v != 'F' && v}
  end

  def display
    puts ""
    min_y = 0
    max_y = occupied.keys.map{|m| m[0,0]}.max
    min_x = occupied.keys.map{|m| m[0,1]}.min
    max_x = occupied.keys.map{|m| m[0,1]}.max
    (min_y..max_y).each do |y|
      print "#{y}\t"
      (min_x..max_x).each do |x|
        print @board[Matrix[[y, x]]] ? @board[Matrix[[y, x]]] : '.'
      end
      puts ""
    end
    puts "sand count: #{occupied.values.count{|c| c=="o"}}"
    puts ""
    # binding.pry
  end

  def best_destination(p)
    destination = [[1, 0], [1, -1], [1, 1]].reject do |delta|
      @board[p + Matrix[delta]]
    end.first
    p + Matrix[destination] if destination
  end

  def drop_sand(p)
    @board[p] = 'o' # drop the sand

    while (destination = best_destination(p))
      @board[p] = nil
      if destination[0,0] >= @max_line_y
        return :infinity
      end
      p = destination
      @board[destination] = 'o'
    end
    p
  end

  def part1
    populate_board(parse)
    while true
      stopped_at = drop_sand(Matrix[[0, 500]])
      # display
      break if stopped_at == :infinity
    end
    occupied.values.select{|c| c=='o'}.count
  end

  def part2
    lines = parse
    populate_board(lines)
    floor_y = @max_line_y + 2
    lines = [
      [
        [floor_y, -1000],
        [floor_y, 1000],
      ]
    ]
    populate_board(lines, 'F')
    while true
      stopped_at = drop_sand(Matrix[[0, 500]])
      # display
      break if stopped_at == Matrix[[0, 500]]
    end
    occupied.values.select{|c| c=='o'}.count
  end
end
