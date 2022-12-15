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
        beacons: [bl],
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
    bl = s[:beacons].first
    radius = distance(sl, bl)

    for_y_intersec = Vector[for_y, sl[1]]
    distance_to_for_y = distance(sl, Vector[for_y, sl[1]])

    (radius - distance_to_for_y + 1).times do |i|
      yield(for_y_intersec + Vector[0, i])
      yield(for_y_intersec + Vector[0, i*-1])
    end
  end

  def part1(for_y = 2000000)
    parse
    no_distress_at = Set.new
    @board.select{|k,v| v[:type] == :sensor}.each do |k, s|
      sweep_sensor_range(s, for_y) do |sl|
        no_distress_at << sl unless @board[sl]
      end
    end
    no_distress_at.count
  end

  def part2
    # parse
  end
end
