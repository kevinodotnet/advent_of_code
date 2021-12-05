#!/usr/bin/env ruby

require 'pry'
require 'set'

def test_input
    <<EOF
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class Line 
    attr_accessor :x1, :y1, :x2, :y2
    def initialize(x1, y1, x2, y2)
        self.x1 = [x1, x2].min
        self.y1 = [y1, y2].min
        self.x2 = [x1, x2].max
        self.y2 = [y1, y2].max
    end
    def horizontal_or_vertical?
        return true if x1 == x2 || y1 == y2
    end
    def intersects(x, y)
        raise StandardError, 'unsupported' unless horizontal_or_vertical?
        (x1..x2).include?(x) && (y1..y2).include?(y)
    end
end

class SolutionA
    def initialize(data)
        @lines = []
        data.split("\n").map do |d|
            match = d.match(/(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/)
            @lines << Line.new(match['x1'].to_i, match['y1'].to_i, match['x2'].to_i, match['y2'].to_i)
            raise StandardError, "regex failure: #{d}" unless match
        end
    end
    def board_str
        @board.map{|b| b.map{|c| c == 0 ? '.' : c}.join(" ")}.join("\n")
    end
    def solve
        max_x = @lines.map{|l| [l.x1, l.x2]}.flatten.max
        max_y = @lines.map{|l| [l.y1, l.y2]}.flatten.max
        @lines = @lines.select{|l| l.horizontal_or_vertical? }
        @board = (0..max_y).map do |y|
            (0..max_x).map{|i| 0}
        end
        @lines.each do |l|
            ((l.y1)..(l.y2)).each do |y|
                ((l.x1)..(l.x2)).each do |x|
                    if l.intersects(x, y)
                        @board[y][x] += 1
                    end
                end
            end
        end
        @board.flatten.select{|d| d>= 2}.count
    end
end

class SolutionB < SolutionA
end

puts "#" * 100
puts "test: #{SolutionA.new(test_input).solve}"
puts "full: #{SolutionA.new(input).solve}"

# puts "#" * 100
# puts "test: #{SolutionB.new(test_input).solve}"
# puts "full: #{SolutionB.new(input).solve}"