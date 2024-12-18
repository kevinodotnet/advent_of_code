class Solution < AbstractSolution
  def parse
    @costs = { a: 3, b: 1 }
    @machines = @data.split("\n\n").map do |m|
      machine = {}

      b = m.split("\n").first
      str, button, x, y = b.match(/Button (.): X(.*), Y(.*)/).to_a
      machine[:a] = { x: x.to_i, y: y.to_i }

      b = m.split("\n").second
      str, button, x, y = b.match(/Button (.): X(.*), Y(.*)/).to_a
      machine[:b] = { x: x.to_i, y: y.to_i }

      b = m.split("\n").last
      str, x, y = b.match(/X=(.*), Y=(.*)/).to_a
      machine[:prize] = { x: x.to_i, y: y.to_i }

      binding.pry if (machine[:prize][:y] / machine[:a][:y]) % 1 != 0
      binding.pry if (machine[:prize][:y] / machine[:b][:y]) % 1 != 0
      binding.pry if (machine[:prize][:x] / machine[:a][:x]) % 1 != 0
      binding.pry if (machine[:prize][:x] / machine[:b][:x]) % 1 != 0

      machine
    end
  end

  def solve
    @machines.map do |m|
      prize_y = m[:prize][:y]
      prize_x = m[:prize][:x]

      ay = m[:a][:y]
      ax = m[:a][:x]
      by = m[:b][:y]
      bx = m[:b][:x]

      price_y = ay * i + by * j
      price_x = ax * i + bx * j

      # max_a_presses = [prize_x / ax, prize_y / ay].max
      # max_b_presses = [prize_x / bx, prize_y / by].max
      # solutions = []
      # max_a_presses.times.map do |i|
      #   break if solutions.any?
      #   max_b_presses.times.map do |j|

      #     y = ay * i + by * j
      #     x = ax * i + bx * j

      #     if x == prize_x && y == prize_y
      #       solutions << {a: i, b: j, cost: (i*3+j)} 
      #     end
      #   end
      # end
      # binding.pry if solutions.count > 1
      # solutions.first
    end
  end

  def part1
    r = solve
    r.compact.sum{|m| m[:cost]}
  end

  def part2
    @machines.each do |m|
      m[:prize][:x] += 10000000000000
      m[:prize][:y] += 10000000000000
    end
    r = solve
    binding.pry
    r.compact.sum{|m| m[:cost]}
  end
end
