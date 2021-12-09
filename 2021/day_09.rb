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
    end

    # puts @data.map{|r| r.join("")}.join("\n")

    def low_points
        lowest = []
        cols = @data.map{|r| r.count}.max
        rows = @data.count
        (0...rows).each do |y|
            (0...cols).each do |x|
                peers = []
                (-1..1).map do |dy|
                    (-1..1).each do |dx|
                        x1 = x + dx
                        y1 = y + dy
                        if (x1 >= 0 && y1 >= 0 && x1 < cols && y1 < rows)
                            peers << {x: x1, y: y1} unless x1 == x && y1 == y
                        end
                    end
                end

                lower = peers.map do |p|
                    @data[y][x] < @data[p[:y]][p[:x]]
                end

                if lower.uniq == [true]
                    lowest << { x: x, y: y, h: @data[y][x]}
                end
            end
        end
        lowest
    end

end

class SolutionB < SolutionA
end

class SolutionATest < Minitest::Test
    def test_the_test_input
        assert_equal 15, SolutionA.new(test_input).low_points.map{|p| p[:h] + 1}.sum
    end
end

puts "##### Solution A #####"
puts "full: #{SolutionA.new(input).low_points.map{|p| p[:h] + 1}.sum}"
