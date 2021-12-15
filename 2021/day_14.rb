#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
load $0.gsub(/\.rb$/,'_test.rb')

class Solution
    attr_accessor :tuples, :insertions, :counts

    def self.input
        File.read($0.gsub(/rb$/,'input'))
    end

    def self.part1
        solution = Solution.parse(input)
        10.times { solution = solution.insert }

        fewest = solution.counts.invert.min.first
        most = solution.counts.invert.max.first
        most - fewest
    end

    def self.part2
        solution = Solution.parse(input)
        40.times { solution = solution.insert }
        solution.most - solution.least
    end

    def initialize(tuples, insertions, counts)
        @tuples = tuples
        @insertions = insertions
        @counts = counts
    end

    def most
        counts.invert.sort.last.first
    end

    def least
        counts.invert.sort.first.first
    end

    def insert
        i = 0
        nt = tuples.dup
        nc = counts.dup
        insertions.each do |k, v|
            count = tuples[k]
            next if count == 0
            t1 = k.split("")[0] + v
            t2 = v + k.split("")[1]
            nt[k] -= count
            nt[t1] += count
            nt[t2] += count
            nc[v] += count
        end
        Solution.new(nt, insertions, nc)
    end

    def count(count_of)
        counts[count_of]
    end

    def self.parse(input)
        tuples = Hash.new { |h, k| h[k] = 0 }
        counts = Hash.new { |h, k| h[k] = 0 }

        template = input.split("\n\n").first.split("")
        (template.count-1).times do |i|
            tuple = [template[i],template[i+1]].compact.join("")
            tuples[tuple] += 1
            counts[template[i]] += 1
        end
        counts[template.last] += 1

        insertions = {}
        input.split("\n\n").last.split("\n").each do |i|
            match = i.match(/(?<from>.*) -> (?<to>.*)/)
            insertions[match[:from]] = match[:to]
        end
        Solution.new(tuples, insertions, counts)
    end
end

puts "##### Solution #####"
puts "part1: #{Solution.part1}"
puts "part2: #{Solution.part2}"
puts "####################"