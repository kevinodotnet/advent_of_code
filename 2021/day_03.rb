#!/usr/bin/env ruby

require 'pry'

def test_input
    <<EOF.split("\n")
EOF
end

def input
    File.read($0.gsub(/rb$/,'input')).split("\n")
end

class SolutionA
    def initialize(data)
    end
    def solve
    end
end

class SolutionB < SolutionA
    def initialize(data)
    end
    def solve
    end
end

puts "#" * 100
puts "test: #{SolutionA.new(test_input).solve}"
puts "full: #{SolutionA.new(input).solve}"

puts "#" * 100
puts "test: #{SolutionB.new(test_input).solve}"
puts "full: #{SolutionB.new(input).solve}"