#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
load $0.gsub(/\.rb$/,'_test.rb')

class Solution
    def initialize(data)
        @connections = Hash.new { |hash, key| hash[key] = {} }
        data.split("\n") do |d|
            se = d.split("-")
            @connections[se[0]][se[1]] = 1
            @connections[se[1]][se[0]] = 1
        end
    end

    def routes
        routes = [
            ["start"]
        ]
        loop_again = true
        while loop_again do
            loop_again = false
            new_routes = []
            routes.each do |r|
                if r.last == "end"
                    new_routes << r
                    next
                end
                @connections[r.last].keys.each do |k|
                    next if r.include?(k) && is_lower?(k)
                    new_route = [r, k].flatten
                    loop_again = true
                    new_routes << new_route
                end
            end
            routes = new_routes
        end
        routes
    end

    def self.input
        File.read($0.gsub(/rb$/,'input'))
    end

    def self.part1
        Solution.new(input).routes.count
    end

    def self.part2
    end

    private

    def is_lower?(s)
        s == s.downcase
    end
end

puts "##### Solution #####"
puts "part1: #{Solution.part1}"
puts "part2: #{Solution.part2}"
puts "####################"
