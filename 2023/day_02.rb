class Solution < AbstractSolution
  def parse
    @data.split("\n").map do |l|
      (game_num, d) = l.split(": ")
      game_num = game_num.match(/Game (\d+)/)[1].to_i
      rounds = d.split(";").map do |r|
        r.split(", ").map do |nc|
          (num, color) = nc.split(" ")
          num = num.to_i
          {
            color => num
          }
        end.reduce({}, :merge).symbolize_keys
      end
      {
        game_num => rounds
      }
    end.reduce({}, :merge)
  end

  def part1(input)
    parse.map do |g, rounds|
      [
        g,
        rounds.map do |r|
          r.map do |color, count|
            count <= input[color]
          end
        end.flatten.any?(false)
      ]
    end.select{|k, v| v == false}.sum{|k, v| k}
  end

  def part2
    parse.map do |g, rounds|
      min = {
      }
      rounds.map do |r|
        r.map do |color, count|
          min[color] = if min[color]
            min[color] > count ? min[color] : count
          else
            count
          end
        end
      end
      min.values.inject(:*)
    end.sum
  end
end
