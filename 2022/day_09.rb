require 'matrix'

class Solution < AbstractSolution
  attr_accessor :head, :tail

  def initialize(*)
    super
    @head = Matrix[[0, 0]]
    @tail = Matrix[[0, 0]]
  end

  def parse
    @moves = @data.split("\n").map{|m| m = m.split(" "); m[1] = m[1].to_i; m}
  end

  def part1
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
        begin
          tail_touched << @tail
          @head = @head + vector[m[0]]
          vector_t_to_h = @head - @tail
          next if vector_t_to_h.to_a.first.map{|i| i.abs}.max <= 1 # is adjacent
          @tail = @tail + Matrix[vector_t_to_h.to_a.first.map{|i| i == 0 ? 0 : i/i.abs}]
        ensure
        end
      end
    end
    tail_touched.count
  end

  def part2
    # parse
  end
end
