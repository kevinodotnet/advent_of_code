#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
load $0.gsub(/\.rb$/,'_test.rb')

class Solution
    attr_accessor :template, :insertions

    def self.input
        File.read($0.gsub(/rb$/,'input'))
    end

    def self.part1
        solution = Solution.parse(input)
        10.times { solution = solution.insert }

        fewest = solution.template.split("").group_by(&:to_s).map { |a| [a[0], a[1].count] }.to_h.invert.min
        most = solution.template.split("").group_by(&:to_s).map { |a| [a[0], a[1].count] }.to_h.invert.max
        most.first - fewest.first
    end

    def self.part2
    end

    def initialize(template, insertions)
        @template = template
        @insertions = insertions
    end

    def insert
        i = 0
        new_template = ""
        while i < template.length do
            r = template.slice(i, 2)
            if insertions[r]
                new_template += r.split("")[0]
                new_template += insertions[r]
            else
                new_template += template[i]
            end
            i += 1
        end
        Solution.new(new_template, insertions)
    end

    def self.parse(input)
        template = input.split("\n\n").first
        insertions = {}
        input.split("\n\n").last.split("\n").each do |i|
            match = i.match(/(?<from>.*) -> (?<to>.*)/)
            insertions[match[:from]] = match[:to]
        end
        Solution.new(template, insertions)
    end
end

puts "##### Solution #####"
puts "part1: #{Solution.part1}"
#puts "part2: #{Solution.part2}"
puts "####################"