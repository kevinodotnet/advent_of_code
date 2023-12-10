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

  def parse2
    @races = [
      {
        time: @data.split("\n").first.gsub(/ */, '').scan(/\d+/).map{|i| i.to_i}.first,
        distance: @data.split("\n").last.gsub(/ */, '').scan(/\d+/).map{|i| i.to_i}.first,
      }
    ]
  end

  def boat_distance(hold_time, race_duration)
    move_time = race_duration - hold_time
    speed = hold_time
    speed * move_time
  end

  def run_races
    @races.map do |r|
      min = 1
      max = r[:time]-1

      cursor = min

      first_win = nil
      last_win = nil

      # find the first win position
      loop do
        cursor = min + ((max - min) / 2)
        if cursor == min || cursor == max
          first_win = [
            min,
            max,
            cursor
          ].select do |i|
            boat_distance(i, r[:time]) > r[:distance]
          end.uniq.min
          break
        end
        distance = boat_distance(cursor, r[:time])
        won = distance > r[:distance]
        if won
          max = cursor
        else
          min = cursor
        end
      end

      # find the last win position
      min = first_win
      max = r[:time]-1
      loop do
        cursor = min + ((max - min) / 2)
        if cursor == min || cursor == max
          last_win = [
            min,
            max,
            cursor
          ].select do |i|
            boat_distance(i, r[:time]) > r[:distance]
          end.uniq.max
          break
        end
        distance = boat_distance(cursor, r[:time])
        won = distance > r[:distance]
        if won
          min = cursor
        else
          max = cursor
        end
      end

      last_win - first_win + 1
    end
  end

  def part1
    parse
    run_races.inject(:*)
  end

  def part2
    parse2
    run_races.inject(:*)
  end
end
