require 'matrix'

class Solution < AbstractSolution
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
    cur = {
      h: Matrix[[0, 0]],
      t: Matrix[[0, 0]]
    }
    tail_touched = Set.new
    @moves.each do |m|
      puts "#" * 50
      puts "CMD: #{m}"
      m[1].times do |i|
        begin
          puts "  (i_s:#{i}) #{cur}"
          tail_touched << cur[:t]
          cur[:h] = cur[:h] + vector[m[0]]
          vector_t_to_h = cur[:h] - cur[:t]
          # vector_t_to_h = Matrix[vector_t_to_h.to_a.map{|v| v.map{|i| i == 0 ? 0 : i/i}}] # cap to 1 in any direction
          next if vector_t_to_h.to_a.first.map{|i| i.abs}.max <= 1 # is adjacent
          puts vector_t_to_h
          # binding.pry if m[0] == "L" && i == 1
          cur[:t] = cur[:t] + Matrix[vector_t_to_h.to_a.first.map{|i| i == 0 ? 0 : i/i.abs}]
        ensure
          puts "  (i_e:#{i}) #{cur}"
        end
      end
    end
    puts "tail_touched.count: #{tail_touched.count}"
    tail_touched.count
    # binding.pry
  end

  def part2
    # parse
  end
end
