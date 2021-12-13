#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
load $0.gsub(/\.rb$/,'_test.rb')

class Solution
    attr_reader :data, :dots, :folds

    def initialize(data, folds)
        @data = data
        @folds = folds
    end

    def self.parse(input)
        dots = input.split("\n\n").first.split("\n").map{|r| r.split(",").map{|i| i.to_i}}
        folds = input.split("\n\n").last.split("\n").map do |line|
            match = line.match(/fold along (?<axis>.)=(?<at>\d+)/)
            {
                axis: match[:axis].to_sym,
                at: match[:at].to_i
            }
        end

        max_x = dots.map{|d| d[0]}.max
        max_y = dots.map{|d| d[1]}.max
        folds = folds
        data = []
        (max_y+1).times do |y|
            row = []
            data << row
            (max_x+1).times do |x|
                row << 0
            end
        end
        dots.each do |d|
            data[d[1]][d[0]] = 1
        end
        Solution.new(data, folds)
    end

    def fold
        remaining_folds = folds.dup
        this_fold = remaining_folds.shift
        if this_fold[:axis] == :y 
            top = data.dup.slice(0...this_fold[:at])
            bottom_flipped = data.dup.slice(this_fold[:at]...data.count).reverse
            top.each_with_index do |row, y|
                row.each_with_index do |d, x|
                    top[y][x] += bottom_flipped[y][x]
                    top[y][x] > 1 ? top[y][x] = 1 : top[y][x]
                end
            end
            Solution.new(top, remaining_folds)
        else
            new_data = data.dup.map do |row|
                left = row.dup.slice(0...this_fold[:at])
                right_flipped = row.dup.slice((this_fold[:at]+1)...row.count).reverse
                left.zip(right_flipped).map{|d| d.max}
            end
            Solution.new(new_data, remaining_folds)
        end
    end

    def visible_count
        data.flatten.select{|d| d == 1}.count
    end

    def board_as_str
        @data.map{|r| r.join("")}.join("\n").gsub(/0/,'.').gsub(/1/,'#').chomp
    end

    def self.input
        File.read($0.gsub(/rb$/,'input'))
    end

    def self.part1
        solution = Solution.parse(input)
        solution = solution.fold
        solution.visible_count
    end

    def self.part2
    end
end

puts "##### Solution #####"
puts "part1: #{Solution.part1}"
#puts "part2: #{Solution.part2}"
puts "####################"
