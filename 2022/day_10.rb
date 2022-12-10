class Solution < AbstractSolution
  def parse
    @data.split("\n")
  end

  def part1
    x = 1
    cycles = parse.map do |l|
      if l == "noop"
        v = {
          cmd: l,
          during: x,
          after: x
        }
        v
      else
        m = l.match(/addx ([-\d+]*)/)
        v = m[1].to_i
        next_x = x + v
        m = [
          {
            cmd: "(1) #{l}",
            during: x,
            after: x
          },
          {
            cmd: "(2) #{l}",
            during: x,
            after: next_x
          },
        ]
        x = next_x
        m
      end
    end.flatten
    strengths = cycles.map.with_index { |c, i| c[:during] * (i + 1) }
    strengths.map.with_index { |v, i| ((i+1) - 20) % 40 == 0 ? v : nil }.compact.sum
  end

  def part2
    # parse
  end
end
