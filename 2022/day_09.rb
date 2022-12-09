require 'matrix'

class Solution < AbstractSolution
  def initialize(*)
    super
  end

  def parse
    @moves = @data.split("\n").map{|m| m = m.split(" "); m[1] = m[1].to_i; m}
  end

  def move(vector)
    @rope[0] = @rope[0] + vector

    @rope.each_with_index do |k, i|
      next if i == 0

      knot = @rope[i]
      prev_knot = @rope[i-1]

      vector_prev_to_knot = prev_knot - knot

      next if vector_prev_to_knot.to_a.first.map{|i| i.abs}.max <= 1 # is adjacent
      knot = knot + Matrix[vector_prev_to_knot.to_a.first.map{|i| i == 0 ? 0 : i/i.abs}]
      @rope[i] = knot
    end
  end

  def solve
    parse
    vector = {
      "U" => Matrix[[0, 1]],
      "L" => Matrix[[-1, 0]],
      "D" => Matrix[[0, -1]],
      "R" => Matrix[[1, 0]],
    }
    tail_touched = Set.new
    @moves.each do |m|
      m[1].times do |i|
        tail_touched << @rope.last
        move(vector[m[0]])
      end
      tail_touched << @rope.last
    end
    tail_touched.count
  end

  def part1
    @rope = []
    2.times do
      @rope << Matrix[[0, 0]]
    end
    solve
  end

  def part2
    @rope = []
    10.times do
      @rope << Matrix[[0, 0]]
    end
    solve
  end
end
