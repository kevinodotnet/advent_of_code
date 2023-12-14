class Solution < AbstractSolution

  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.

  def parse
    @grid = @data.split("\n").map{|l| l.split("")}
    @start = @gr
    row, @start_y = @grid.each_with_index.detect{|v, i| v.include?("S") }
    @start_x = row.index("S")

    @steps = @grid.map do |y|
      y.map do |x|
        '.'
      end
    end

    @steps[@start_y][@start_x] = 0
  end

  def connected_unvisited(y, x)
    directions = {
      left: [0, -1],
      up: [-1, 0],
      right: [0, 1],
      down: [1, 0]
    }

    connected = directions.select do |dir, v|
      dy = v[0]
      dx = v[1]
      y1 = y + dy
      x1 = x + dx
      next if y1 < 0 || y1 >= @grid.count
      next if x1 < 0 || x1 >= @grid[0].count
      tile = @grid[y1][x1]

      dir == :left && ["-", "L", "F"].include?(tile) || \
        dir == :up && ["|", "7", "F"].include?(tile) || \
        dir == :right && ["-", "J", "7"].include?(tile) || \
        dir == :down && ["|", "J", "L"].include?(tile)
    end

    unvisited = connected.map do |dir, v|
      dy = v[0]
      dx = v[1]
      y1 = y + dy
      x1 = x + dx

      next unless @steps[y1][x1] == '.' # skip if already visisted (fewer steps)
      [y + v[0], x + v[1]]
    end.compact

    # puts "  cu: #{y},#{x}: #{unvisited}"
    unvisited
  end

  def part1
    parse
    # puts ""
    # puts @grid.map{|l| l.join("")}.join("\n")
    # puts ""
    locs = [
      [@start_y, @start_x]
    ]
    while locs.count > 0 do
      # puts "locs.count: #{locs.count} #{@steps.flatten.reject{|s| s == "."}.count} / #{@steps.flatten.count}"
      # puts ""
      # puts @steps.map{|l| l.join("")}.join("\n")
      # puts ""
      loc = locs.shift
      steps_to_here = @steps[loc[0]][loc[1]]
      connected_unvisited(loc[0], loc[1]).each do |l|
        @steps[l[0]][l[1]] = steps_to_here + 1
        locs << l
      end
      # binding.pry
    end
    @grid.each_with_index.map do |row, y|
      row.each_with_index.map do |c, x|
        print @steps[y][x] == '.' ? '.' : c
      end
      puts "\n"
    end
    @steps.flatten.reject{|s| s == "."}.max
  end

  def part2
    parse
    part1 # draw the line

    polygon = []
    @steps.each_with_index.map do |row, y|
      matches = row.each_with_index.map do |c, x|
        next if c == '.'
        [y, x]
      end.compact
      next if matches == []
      polygon += matches
    end.compact

    point_in_polygon?([0, 0], polygon)
  end

  private

  #########################################################################################################
  # ChatGPT:
  # As a Ruby programmer solving Advent of Code problems, determine what tiles on a grid are
  # enclosed by any polygon that can be drawn on the grid.
  #
  # Determining which tiles on a grid are enclosed by any polygon is a more complex problem.
  # This is known as the Point In Polygon (PIP) problem. There are several algorithms to solve this,
  # but one of the most common is the Ray Casting algorithm.
  #
  # The Ray Casting algorithm works by drawing a line from the point to a location outside of the polygon.
  # If the line intersects the polygon an odd number of times, the point is inside the polygon. If it
  # intersects an even number of times, the point is outside.
  #
  # Here's a simple implementation in Ruby:
  #########################################################################################################

  def point_in_polygon?(point, polygon)
    return false if polygon.include?(point)
    y, x = point
    intersections = 0



    point1 = polygon[-1] # Start with the last point in polygon
    binding.pry

    polygon.each do |point2|
      if (point1[1] < y && point2[1] >= y) || (point1[1] >= y && point2[1] < y) # If edge is at least partially horizontal
        if x < (point2[0] - point1[0]) * (y - point1[1]) / (point2[1] - point1[1]) + point1[0] # If intersection is to left of point
          intersections += 1
        end
      end
      point1 = point2
    end

    intersections.odd?
  end

  def enclosed_tiles(polygon, grid)
    # grid is a 2D array
    # Returns an array of points [x, y] that are enclosed by the polygon

    enclosed_points = []

    grid.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if point_in_polygon?([x, y], polygon)
          enclosed_points << [x, y]
        end
      end
    end

    enclosed_points
  end
end
