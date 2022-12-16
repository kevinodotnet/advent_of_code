class Solution < AbstractSolution
  def parse
    @board = {} # key=vector, val=sensor or beacon
    p = @data.split("\n").map do |l|
      sx, sy, bx, by = l.scan(/[-\d]+/).map(&:to_i)
      sl = Vector[sy, sx]
      bl = Vector[by, bx]
      @board[sl] = {
        location: sl,
        type: :sensor,
        beacon: bl,
        distance: distance(sl, bl)
      }
      @board[bl] = {
        location: bl,
        type: :beacon,
      }
    end
  end

  def distance(p1, p2)
    distance = (p1 - p2)
    distance = distance[0].abs + distance[1].abs
  end

  def sweep_sensor_range(s, for_y)
    sl = s[:location]
    bl = s[:beacon]
    radius = distance(sl, bl)

    for_y_intersec = Vector[for_y, sl[1]]
    distance_to_for_y = distance(sl, Vector[for_y, sl[1]])

    (radius - distance_to_for_y + 1).times do |i|
      yield(for_y_intersec + Vector[0, i])
      yield(for_y_intersec + Vector[0, i*-1])
    end
  end

  def sensors
    @sensors ||= @board.select{|k,v| v[:type] == :sensor}
  end

  def part1(for_y = 2000000)
    parse
    no_distress_at = Set.new
    sensors.each do |k, s|
      sweep_sensor_range(s, for_y) do |sl|
        no_distress_at << sl unless @board[sl]
      end
    end
    no_distress_at.count
  end

  def part2(mx = 4000000.0, my = 4000000.0)
    parse
    x = 0
    y = 0
    while y <= my
      x = 0
      while x <= mx
        p = Vector[y,x]

        jumps = sensors.map do |s|
          s = s[1]
          d_to_p = distance(s[:location], p)
          s[:distance] - distance(s[:location], p) if d_to_p <= s[:distance]
        end.compact

        return x * 4000000 + y unless jumps.any?

        jump = jumps.max
        x += jump == 0 ? 1 : jump
      end
      y += 1
    end
  end
end
