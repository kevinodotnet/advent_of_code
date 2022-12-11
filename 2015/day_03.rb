require 'matrix'

class Solution < AbstractSolution
  def parse
    @data.split("")
  end

  def part1
    location = Matrix[[0,0]]
    trail = {}
    dirs = {
      "^" => Matrix[[0,1]],
      ">" => Matrix[[1,0]],
      "v" => Matrix[[0,-1]],
      "<" => Matrix[[-1,0]],
    }
    parse.each do |c|
      trail[location] ||= 0
      case c 
      when "^"
        trail[location] += 1
        location = location + dirs[c]
      when ">"
        trail[location] += 1
        location = location + dirs[c]
        trail[location] ||= 0
        trail[location] += 1
      when "v"
        trail[location] += 1
        location = location + dirs[c]
      when "<"
        trail[location] += 1
        location = location + dirs[c]
        trail[location] ||= 0
        trail[location] += 1
      end
    end
    trail.values.count{|i| i>0}
  end

  def part2
    parse
  end
end
