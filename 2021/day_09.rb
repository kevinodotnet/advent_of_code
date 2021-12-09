#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

def test_input
    <<~EOF
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class SolutionA
    def initialize(data)
        @data = data.split("\n").map{|l| l.split("").map{|i| i.to_i}}
        @xx = 0
    end

    def cols
        @cols ||= @data.map{|r| r.count}.max
    end

    def rows
        @rows ||= @data.count
    end

    def peers(x, y)
        p = []
        (-1..1).map do |dy|
            (-1..1).each do |dx|
                next unless dx.abs + dy.abs == 1
                x1 = x + dx
                y1 = y + dy
                if (x1 >= 0 && y1 >= 0 && x1 < cols && y1 < rows)
                    p << {x: x1, y: y1, h: @data[y1][x1]}
                end
            end
        end
        p
    end

    def low_points
        lowest = []
        (0...rows).each do |y|
            (0...cols).each do |x|
                lower = peers(x, y).map do |p|
                    @data[y][x] < @data[p[:y]][p[:x]]
                end

                if lower.uniq == [true]
                    lowest << { x: x, y: y, h: @data[y][x]}
                end
            end
        end
        lowest
    end

    def basins
        low_points.map do |l|
            basin = Set.new([l])
            new_points = [l]
            while new_points.any? do
                cursor = basin.dup
                new_points.each do |p|
                    new_points = peers(p[:x], p[:y]).select{|p| p[:h] < 9}
                    basin = basin + Set.new(new_points)
                end
                new_points = basin - cursor
            end
            basin
        end
    end

end

class SolutionB < SolutionA
end

class SolutionATest < Minitest::Test
    def test_the_test_input
        assert_equal 15, SolutionA.new(test_input).low_points.map{|p| p[:h] + 1}.sum
    end
    def test_basins
        s = SolutionA.new(test_input).basins
        expected = [3,9,14,9]
        assert_equal expected, s.map{|b| b.count{|s| s[:h]}}
    end
    def test_part2_input 
        assert_equal 1023660, SolutionA.new(input).basins.map{|b| b.count}.sort.last(3).inject(:*)
    end
end

puts "##### Solution A #####"
puts "p1: #{SolutionA.new(input).low_points.map{|p| p[:h] + 1}.sum}"
puts "p2: #{SolutionA.new(input).basins.map{|b| b.count}.sort.last(3).inject(:*)}"
