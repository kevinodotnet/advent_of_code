class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.scan(/-?\d+/).map(&:to_i)}
    @robots = @data.map do |d|
      x, y, dx, dy = d
      {x: x, y: y, dx: dx, dy: dy}
    end
  end

  def print_board
    @board_y.times do |y|
      @board_x.times do |x|
        robots_on_spot = @robots.select{|r| r[:x] == x && r[:y] == y}.count
        print robots_on_spot > 0 ? robots_on_spot : "."
      end
      puts ""
    end
  end

  def step
    @robots.each do |r|
      r[:x] += r[:dx]
      r[:y] += r[:dy]
      r[:x] %= @board_x
      r[:y] %= @board_y
    end
  end

  def part1(board_x = 101, board_y = 103, seconds = 100)
    @board_x = board_x
    @board_y = board_y
    seconds.times do |i|
      step
    end

    quadrants = {}
    @robots.each do |r|
      top_bottom = if r[:y] < @board_y / 2
        :top
      elsif r[:y] > @board_y / 2
        :bottom
      end

      left_right = if r[:x] < @board_x / 2
        :left
      elsif r[:x] > @board_x / 2
        :right
      end

      quadrants[top_bottom] ||= {}
      quadrants[top_bottom][left_right] ||= 0
      quadrants[top_bottom][left_right] += 1
    end

    [:top, :bottom].map do |tb|
      [:left, :right].map do |lr|
        quadrants[tb][lr]
      end
    end.flatten.reduce(&:*)
  end

  def part2(board_x = 101, board_y = 103)
    @board_x = board_x
    @board_y = board_y
    seconds = 0
    loop do
      seconds += 1
      step

      # Do "CROPS" from previous puzzle.
      # Look for cases where the biggest crop is WAY bigger than the next 5 crops average, skip 1
      # This only happens when the robots sync up for the tree (and box) but everything else is mainly alone

    end
  end
end
