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

    inside = @grid.each_with_index.map do |row, y|
      row.each_with_index.map do |c, x|
        nil
      end
    end

    inside.each_with_index do |row, y|
      row.each_with_index do |c, x|
        break if @grid[y][x] != '.'
        inside[y][x] = false
      end
      x = row.count - 1
      while x >= 0 do
        break if @grid[y][x] != '.'
        inside[y][x] = false
        x -= 1
      end
    end

    @grid.each_with_index do |row, y|
      puts ""
      puts "process row"
      puts row.join("")
      puts ""

      prev_tile = nil
      intersections = 0

      row.each_with_index do |c, x|
        if inside[y][x] == false
          # outer shell; already determined to be outside
          prev_tile = c
          next
        end

        if @steps[y][x] == '.'
          # on an empty tile, inside?
          inside[y][x] = intersections.odd?
        else
          # on a pipe
          intersections += 1
          # if prev_tile == '.'
          #   # stepped onto trail, vs. continuing on trail which is not an intersection?
          #   intersections += 1
          # end
        end
        prev_tile = c
      end
    end
    inside.flatten.count{|t| t}
  end
end
