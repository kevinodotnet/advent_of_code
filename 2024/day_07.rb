class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map{|l| l.scan(/\d+/).map(&:to_i)}
  end

  def solve(operations)
    r = @data.select do |r|
      e = r.deep_dup
      goal = e.shift
      values = [e.shift]
      while e.length > 0
        b = e.shift
        values = values.flatten.map do |v|
          operations.map do |op|
            if op == '|'
              [v,b].join('').to_i
            else
              v.send(op, b)
            end
          end.reject{|v| v > goal}
        end
      end
      values.flatten.any?(goal)
    end
    r.map{|e| e[0]}.sum
  end

  def part1
    solve([:*, :+])
  end

  def part2
    solve([:*, :+, '|'])
  end
end
