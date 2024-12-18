require 'z3'

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

      machine
    end
  end

  def solve
    @machines.map do |m|
      py = m[:prize][:y]
      px = m[:prize][:x]

      ay = m[:a][:y]
      ay = m[:a][:y]
      ax = m[:a][:x]
      by = m[:b][:y]
      bx = m[:b][:x]

      solver = Z3::Solver.new
      g = Z3.Int('g')
      f = Z3.Int('f')

      solver.assert(g * ay + f*by == py)
      solver.assert(g * ax + f*bx == px)
      solver.model[g].to_i * 3 + solver.model[f].to_i if solver.satisfiable?
    end
  end

  def part1
    solve.compact.sum
  end

  def part2
    @machines.each do |m|
      m[:prize][:x] += 10000000000000
      m[:prize][:y] += 10000000000000
    end
    solve.compact.sum
  end
end
