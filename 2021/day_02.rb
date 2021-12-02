#!/usr/bin/env ruby

require 'pry'

def test_input
    <<EOF.split("\n")
forward 5
down 5
forward 8
up 3
down 8
forward 2
EOF
end

def input
    File.read($0.gsub(/rb$/,'input')).split("\n")
end

class SolutionA
    def initialize(data)
        @data = parse_commands(data)
        @h = 0
        @d = 0
    end
    def parse_commands(data)
        data.map do |d|
            d = d.split(" ")
            {
                cmd: d[0],
                val: d[1].to_i
            }
        end
    end
    def solve
        @data.each do |d|
            case d[:cmd]
            when 'forward'
                @h += d[:val]
            when 'up'
                @d -= d[:val]
            when 'down'
                @d += d[:val]
            else
                raise StandardError, "Unknown CMD #{d[:cmd]}"
            end
        end
        @h * @d
    end
end

class SolutionB < SolutionA
end

puts "#" * 100
puts "test 150: #{SolutionA.new(test_input).solve}"
puts "full: #{SolutionA.new(input).solve}"

# puts "#" * 100
# puts "expecting 5"
# puts SolutionB.new(test_input).solve
# puts SolutionB.new(input).solve

# --- Day 2: Dive! ---
# Now, you need to figure out how to pilot this thing.

# It seems like the submarine can take a series of commands like forward 1, down 2, or up 3:

# forward X increases the horizontal position by X units.
# down X increases the depth by X units.
# up X decreases the depth by X units.
# Note that since you're on a submarine, down and up affect your depth, and so they have the opposite result of what you might expect.

# The submarine seems to already have a planned course (your puzzle input). You should probably figure out where it's going. For example:

# forward 5
# down 5
# forward 8
# up 3
# down 8
# forward 2
# Your horizontal position and depth both start at 0. The steps above would then modify them as follows:

# forward 5 adds 5 to your horizontal position, a total of 5.
# down 5 adds 5 to your depth, resulting in a value of 5.
# forward 8 adds 8 to your horizontal position, a total of 13.
# up 3 decreases your depth by 3, resulting in a value of 2.
# down 8 adds 8 to your depth, resulting in a value of 10.
# forward 2 adds 2 to your horizontal position, a total of 15.
# After following these instructions, you would have a horizontal position of 15 and a depth of 10. (Multiplying these together produces 150.)

# Calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final 
#     horizontal position by your final depth?