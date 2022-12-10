class Solution < AbstractSolution
  def parse
    @data.split("\n")
  end

  def run_cpu
    x = 1
    parse.map do |l|
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
  end

  def part1
    cycles = run_cpu
    strengths = cycles.map.with_index { |c, i| c[:during] * (i + 1) }
    strengths.map.with_index { |v, i| ((i+1) - 20) % 40 == 0 ? v : nil }.compact.sum
  end

  def part2
    screen = (0..5).map { (0..39).map{nil} }
    cycles = run_cpu
    cycles.each_with_index do |c, i|
      screen[i] = (c[:during]-1..c[:during]+1).include?((i) % 40)
    end
    puts screen.each_slice(40).map {|r| r.map{|v| v ? '#' : '.'}.join("")}.join("\n")
  end
end
