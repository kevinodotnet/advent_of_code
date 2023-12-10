class Solution < AbstractSolution
  def parse
    t = @data.split("\n").first.scan(/\d+/).map{|i| i.to_i}
    d = @data.split("\n").last.scan(/\d+/).map{|i| i.to_i}
    @races = t.each_with_index.map do |_, i|
      {
        time: t[i],
        distance: d[i]
      }
    end
  end

  def boat_distance(hold_time, race_duration)
    move_time = race_duration - hold_time
    speed = hold_time
    distance = 0
    move_time.times do
      distance += speed
    end

    distance
  end

  def part1
    parse
    @races.map do |r|
      r[:variants] = (1..(r[:time]-1)).map do |hold_time|
        distance = boat_distance(hold_time, r[:time])
        next if distance <= r[:distance]
        {
          hold_time: hold_time,
          distance: distance
        }
      end.compact
    end
    @races.map{|r| r[:variants].count}.inject(:*)
  end

  def part2
    parse
  end
end
