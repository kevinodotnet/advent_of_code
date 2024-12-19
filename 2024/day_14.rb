class Solution < AbstractSolution
  DIRS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]

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
      # Look for case where the biggest crop is WAY bigger than typical (the first 50 seconds)
      # This only happens when the robots sync up for the tree (and box) but everything else is mainly alone
      
      crops = {}
      points = {}
      @robots.each do |r|
        r[:crop] = SecureRandom.uuid
        crops[r[:crop]] = Set.new
        crops[r[:crop]] << r
        points[[r[:y], r[:x]]] = r
      end
      @robots.each do |r|
        DIRS.each do |d|
          py = r[:y] + d[0]
          px = r[:x] + d[1]
          peer = points[[py, px]]
          next unless peer

          r_crop_id = r[:crop]
          p_crop_id = peer[:crop]

          next if r_crop_id == p_crop_id

          crops[p_crop_id].each do |p|
            p[:crop] = r_crop_id
            crops[r_crop_id] << p
          end
          crops.delete(p_crop_id)
        end
      end
      areas = crops.values.map{|c| c.count}
      return seconds if areas.max > 20
    end
  end
end
