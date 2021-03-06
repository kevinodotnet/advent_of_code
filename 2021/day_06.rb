#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

def test_input
    <<~EOF
    3,4,3,1,2
    EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class SolutionA
    def initialize(data)
        @data = data.split(",").map{|i| i.to_i}
    end
    def solve(days:)
        (0...days).each do |day|
            # age a day
            babies = []
            @data.each_with_index do |f, i|
                @data[i] -= 1
                if @data[i] < 0
                    babies << 8
                    @data[i] = 6
                end
            end
            babies.each do |b|
                @data << b
            end
        end
        population
    end
    def population
        @data
    end
end

class SolutionB < SolutionA
    def initialize(data)
        @data = {}
        data.split(",").map{|i| i.to_i}.each do |d|
            @data[d] = 0 unless @data[d]
            @data[d] += 1
        end
    end
    def solve(days:)
        (0...days).each do |day|
            new_data = {}
            (-1..8).each do |i|
                new_data[i] = 0
            end
            @data.keys.each do |c|
                new_data[c-1] = @data[c]
            end
            if new_data[-1] > 0
                new_data[8] += new_data[-1]
                new_data[6] += new_data[-1]
                new_data[-1] = 0
            end
            @data = new_data
        end
        @data.values.sum
    end
end

class SolutionATest < Minitest::Test
    def test_the_test_input
        expected_by_day = <<~EOF
        3,4,3,1,2
        2,3,2,0,1
        1,2,1,6,0,8
        0,1,0,5,6,7,8
        6,0,6,4,5,6,7,8,8
        5,6,5,3,4,5,6,7,7,8
        4,5,4,2,3,4,5,6,6,7
        3,4,3,1,2,3,4,5,5,6
        2,3,2,0,1,2,3,4,4,5
        1,2,1,6,0,1,2,3,3,4,8
        0,1,0,5,6,0,1,2,2,3,7,8
        6,0,6,4,5,6,0,1,1,2,6,7,8,8,8
        5,6,5,3,4,5,6,0,0,1,5,6,7,7,7,8,8
        4,5,4,2,3,4,5,6,6,0,4,5,6,6,6,7,7,8,8
        3,4,3,1,2,3,4,5,5,6,3,4,5,5,5,6,6,7,7,8
        2,3,2,0,1,2,3,4,4,5,2,3,4,4,4,5,5,6,6,7
        1,2,1,6,0,1,2,3,3,4,1,2,3,3,3,4,4,5,5,6,8
        0,1,0,5,6,0,1,2,2,3,0,1,2,2,2,3,3,4,4,5,7,8
        6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8
        EOF

        expected_by_day = expected_by_day.split("\n").map{|m| m.split(',').map{|i| i.to_i}}
        expected_by_day.each_with_index do |expected, day|
            assert_equal expected, SolutionA.new(test_input).solve(days: day), message: "Failed on day #{day}"
        end

        assert_equal 5934, SolutionA.new(test_input).solve(days: 80).count
    end
end

class SolutionBTest < Minitest::Test
    def test_p2
        expected_by_day = <<~EOF
        3,4,3,1,2
        2,3,2,0,1
        1,2,1,6,0,8
        0,1,0,5,6,7,8
        6,0,6,4,5,6,7,8,8
        5,6,5,3,4,5,6,7,7,8
        4,5,4,2,3,4,5,6,6,7
        3,4,3,1,2,3,4,5,5,6
        2,3,2,0,1,2,3,4,4,5
        1,2,1,6,0,1,2,3,3,4,8
        0,1,0,5,6,0,1,2,2,3,7,8
        6,0,6,4,5,6,0,1,1,2,6,7,8,8,8
        5,6,5,3,4,5,6,0,0,1,5,6,7,7,7,8,8
        4,5,4,2,3,4,5,6,6,0,4,5,6,6,6,7,7,8,8
        3,4,3,1,2,3,4,5,5,6,3,4,5,5,5,6,6,7,7,8
        2,3,2,0,1,2,3,4,4,5,2,3,4,4,4,5,5,6,6,7
        1,2,1,6,0,1,2,3,3,4,1,2,3,3,3,4,4,5,5,6,8
        0,1,0,5,6,0,1,2,2,3,0,1,2,2,2,3,3,4,4,5,7,8
        6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8
        EOF

        expected_by_day = expected_by_day.split("\n").map{|m| m.split(',').map{|i| i.to_i}}
        expected_by_day.each_with_index do |expected, day|
            assert_equal expected.count, SolutionB.new(test_input).solve(days: day), message: "Failed on day #{day}"
        end

        assert_equal 5934, SolutionB.new(test_input).solve(days: 80)
        assert_equal 26984457539, SolutionB.new(test_input).solve(days: 256)
    end
end

puts "##### Solution A #####"
puts "test: #{SolutionA.new(test_input).solve(days: 80).count}"
puts "80  : #{SolutionA.new(input).solve(days: 80).count}"
puts "##### Solution B #####"
puts "80  : #{SolutionB.new(input).solve(days: 80)}"
puts "256 : #{SolutionB.new(input).solve(days: 256)}"
