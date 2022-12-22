class Rock
  attr_reader :points
  def initialize(points)
    @points = points
  end

  def h
    @h ||= points.map{|p| p[0]}.max + 1
  end

  def can_go?(board, y, x)
    points.all? do |p|
      check_y = p[0] + y
      check_x = p[1] + x
      if check_x < 0 || check_x > 6
        false
      else
        !board[check_y].include?(check_x)
      end
    end
  end
end

class Solution < AbstractSolution
  def parse
    @wind = @data.chomp.split("").map{|c| c == ">" ? 1 : -1}
    @rocks = [
      #
      # ####
      #
      [
        [0,0], [0,1], [0,2], [0,3],
      ],
      #
      #  #
      # ###
      #  #
      #
      [
               [0,1],
        [1,0], [1,1], [1,2],
               [2,1],
      ],
      #
      #   #
      #   #
      # ###
      #
      [
                      [0,2],
                      [1,2],
        [2,0], [2,1], [2,2],
      ],
      #
      # #
      # #
      # #
      # #
      #
      [
        [0,0],
        [1,0],
        [2,0],
        [3,0],
      ],
      #
      # ##
      # ##
      #
      [
        [0,0], [0,1],
        [1,0], [1,1],
      ],
    ].map do |r|
      Rock.new(r)
    end
    @board = [ Set.new((0..6)) ] # initialize with floor
  end

  def display(rock = nil, y = nil, x = nil)
    tmp_board = @board.map{|s| s.dup}
    if rock
      rock.points.each do |p|
        tmp_board[y + p[0]].add(x + p[1])
      end
    end

    out = tmp_board.map.with_index do |r, i|
      o = []
      o << "[#{i}]\t"
      o << "|"
      (0..6).each do |x|
        o << (r.include?(x) ? "#" : ".")
      end
      o << "|"
      o
    end
    res = out.map{|r| r.join("")}.join("\n")
    puts res
    res
  end

  def drop_rock(rock, rock_i, wind_i)
    # position new rock at top of board, expanded as needed
    non_empty_i = @board.find_index{|r| r != Set.new}
    x = 2
    y = non_empty_i - 3 - rock.h
    if y < 0
      y.abs.times { @board.unshift(Set.new) } if y < 0
      y = 0
    end

    while true
      wind = @wind[wind_i % @wind.count]
      # display(rock, y, x)

      wind_i += 1

      # if can, shift rock left or right
      if rock.can_go?(@board, y, x + wind)
        x += wind
        # display(rock, y, x)
      end

      # return if the rock cannot drop down
      if !rock.can_go?(@board, y+1, x)
        rock.points.each do |p|
          @board[y + p[0]].add(x + p[1])
        end
        return wind_i
      end

      # otherwise, continue down
      y += 1
  end

    binding.pry # should not be reachable
  end

  def part1(count = 2022)
    parse
    wind_i = 0
    count.times do |rock_i|
      rock = @rocks[rock_i % @rocks.count]
      wind_i = drop_rock(rock, rock_i, wind_i)
      # display
    end
    @board.count - @board.find_index{|r| r != Set.new} - 1
  end

  def part2
    # parse
  end
end
