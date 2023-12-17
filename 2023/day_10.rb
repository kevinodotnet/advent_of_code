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
      puts "# inside row"
      puts row.join("")
      intersections = 0
      on_trail = nil
      prev_on_trail = nil
      row.each_with_index.map do |c, x|
        if @steps[y][x] != '.'
          on_trail = true
        else
          on_trail = false
        end

        if prev_on_trail.nil?
          # first step
          prev_on_trail = on_trail
        end



        binding.pry unless prev_on_trail == on_trail

        # intersections += 1 unless on_trail
        # puts "c: #{c} i:#{intersections}"
        intersections.odd? #  && @steps[y][x] == '.' # is not pipe, and is inside
      end
    end

    binding.pry


  end
end
