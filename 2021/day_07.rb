#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

def test_input
    <<~EOF
    16,1,2,0,4,2,7,1,2,14
    EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class SolutionA
    def initialize(data)
        @data = data.split(",").map{|i| i.to_i}
    end
    def fuel_to_align_on(location)
        fuel_used = @data.map do |d|
            (location-d).abs
        end
        fuel_used.sum
    end
    def solve
        r = (@data.min..@data.max).map do |location|
            fuel_to_align_on(location)
        end
        r.min
    end
end

class SolutionB < SolutionA
    def initialize(data)
        super
        @data = @data.sort
        @cache = {}
    end
    def fuel_to_align_on(location)
        @cache[location] ||= begin
            fuel = 0
            @data.each do |d|
                steps = (location-d).abs
                while steps > 0 do
                    fuel += steps
                    steps -= 1
                end
            end
            fuel
        end
    end
    def solve
        location = @data[@data.count/2]
        cache = {}
        range = (@data.min..@data.max)
        while range.include?(location) do
            used_here = fuel_to_align_on(location)
            if fuel_to_align_on(location-1) < used_here
                location -= 1
            elsif fuel_to_align_on(location+1) < used_here
                location += 1
            else
                return used_here
            end
        end
        raise StandardError, 'todo'
    end
end

class SolutionTest < Minitest::Test
    def test_toy1
        input = "1,2,3"
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(1)
        assert_equal 2, SolutionA.new(input).fuel_to_align_on(2)
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(3)
        assert_equal 2, SolutionA.new(input).solve
    end
    def test_toy2
        input = "1,3"
        assert_equal 2, SolutionA.new(input).fuel_to_align_on(1)
        assert_equal 2, SolutionA.new(input).solve
        input = "1,4"
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(1)
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(2)
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(3)
        assert_equal 3, SolutionA.new(input).fuel_to_align_on(4)
        assert_equal 3, SolutionA.new(input).solve
    end
    def test_the_test_input
        [
            {
                align_on: 2,
                fuel_required: 206
            },
            {
                align_on: 5,
                fuel_required: 168
            },
        ].each do |scenario|
            assert_equal scenario[:fuel_required], SolutionB.new(test_input).fuel_to_align_on(scenario[:align_on])
        end
        assert_equal 168, SolutionB.new(test_input).solve
    end
end

puts "##### Solution A #####"
puts "full: #{SolutionA.new(input).solve}"
puts "full: #{SolutionB.new(input).solve}"
