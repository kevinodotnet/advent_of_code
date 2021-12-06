#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

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
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
    end
    def diagonal?
        (x2-x1).abs == (y2-y1).abs
    end
    def horizontal?
        y1 == y2
    end
    def vertical?
        x1 == x2
    end
    def horizontal_or_vertical?
        horizontal? || vertical?
    end
    def points
        @points ||= begin
            x_inc = if x1 == x2
                0
            elsif x2 > x1
                1
            else
                -1
            end
            y_inc = if y1 == y2
                0
            elsif y2 > y1
                1
            else
                -1
            end
            count = [x2-x1, y2-y1].map{|i| i.abs}.max
            @points = (0..count).map do |i|
                r = {
                    x: x1 + (x_inc * i),
                    y: y1 + (y_inc * i)
                }
                r
            end
            @points
        end
    end
    def intersects(x, y)
        if horizontal_or_vertical?
            (x1..x2).include?(x) && (y1..y2).include?(y)
        else
            (x1..x2).include?(x) && (y1..y2).include?(y) && (x-x1 == y-y1)
        end
        # return points.include?({x: x, y: y})
    end
    def to_s
        {
            x1: x1,
            y1: y1, 
            x2: x2, 
            y2: y2
        }.to_s
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
        max_x = @lines.map{|l| [l.x1, l.x2]}.flatten.max
        max_y = @lines.map{|l| [l.y1, l.y2]}.flatten.max
        @board = (0..max_y).map do |y|
            (0..max_x).map{|i| 0}
        end
    end
    def board_str
        @board.map{|b| b.map{|c| c == 0 ? '.' : c}.join("")}.join("\n")
    end
    def solve
        @lines = @lines.select{|l| l.horizontal_or_vertical? }
        @lines.each_with_index do |l, i|
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
    def lines
        @lines
    end
end

class SolutionB < SolutionA
    def solve
        @lines = @lines.select{|l| l.diagonal? || l.horizontal_or_vertical? }
        @lines.each_with_index do |l, i|
            l.points.each do |p|
                @board[p[:y]][p[:x]] += 1
            end
        end
        @board.flatten.select{|d| d>= 2}.count
    end
end

class LineTest < Minitest::Test
    def test_diagonal
        assert Line.new(0, 0, 2, 2).diagonal?
        refute Line.new(0, 0, 2, 1).diagonal?
        assert Line.new(1, 1, 99, 99).diagonal?
        refute Line.new(0, 1, 99, 99).diagonal?
    end
    
    def test_points_1
        expected = [
            {x: 0, y: 0},
            {x: 1, y: 1},
            {x: 2, y: 2},
        ]
        assert_points(expected, Line.new(2, 2, 0, 0).points)
        assert_points(expected, Line.new(0, 0, 2, 2).points)
    end

    def test_points_1
        expected = [
            {x: 0, y: 0},
            {x: 1, y: 1},
            {x: 2, y: 2},
        ]
        assert_points(expected, Line.new(2, 2, 0, 0).points)
        assert_points(expected, Line.new(0, 0, 2, 2).points)
    end

    def test_points_2
        expected = [{:x=>9, :y=>4}, {:x=>8, :y=>4}, {:x=>7, :y=>4}, {:x=>6, :y=>4}, {:x=>5, :y=>4}, {:x=>4, :y=>4}, {:x=>3, :y=>4}]
        assert_points(expected, Line.new(9, 4, 3, 4).points)
    end
    def test_intersects
        line = Line.new(0, 0, 2, 2)
        assert line.intersects(1,1)
        refute line.intersects(0,2)
        line = Line.new(0, 1, 0, 5)
        assert line.intersects(0, 2)
        refute line.intersects(0, 0)
        assert line.intersects(0, 1)
        assert line.intersects(0, 2)
        assert line.intersects(0, 3)
        assert line.intersects(0, 4)
        assert line.intersects(0, 5)
        refute line.intersects(0, 6)
    end

    private

    def assert_points(p1, p2)
        assert_equal p1.count, p2.count
        p1.each do |a|
            assert p2.include?(a), message: "#{p1} != #{p2}"
        end
    end
end

class SolutionBTest < Minitest::Test
    def test_the_test_input
        expected = <<~EOF
            1.1....11.
            .111...2..
            ..2.1.111.
            ...1.2.2..
            .112313211
            ...1.2....
            ..1...1...
            .1.....1..
            1.......1.
            222111....
        EOF
        s = SolutionB.new(test_input)
        s.solve
        assert_equal expected.split("\n").join(""), s.board_str.split("\n").join("")
    end
end

# puts "#" * 100





# puts "test: #{SolutionA.new(test_input).solve}"
# puts "full: #{SolutionA.new(input).solve}"

# puts "#" * 100
puts "test: #{SolutionB.new(test_input).solve}"
puts "full: #{SolutionB.new(input).solve}"
# puts "#" * 100
