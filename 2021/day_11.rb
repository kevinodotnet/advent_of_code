#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
load $0.gsub(/\.rb$/,'_test.rb')

class Board
    attr_reader :data, :step, :flashed

    def initialize(data, step = 0)
        @data = data.chomp.split("\n").map{|l| l.split("").map{|i| i.to_i}}
        @step = step
        @flashed = []
        (0...@data.count).each do |y|
            row = []
            flashed << row
            (0...@data[y].count).each do |x|
                row << nil
            end
        end
    end
    
    def data_as_string
        data.map{|r| r.join("")}.join("\n")
    end

    def flash(y, x, nd)
        return unless nd[y][x] > 9
        return if @flashed[y][x]
        @flashed[y][x] = 1
        (-1..1).each do |dy|
            (-1..1).each do |dx|
                y1 = y + dy
                x1 = x + dx
                next if dy == 0 && dx == 0
                next if y1 < 0 || x1 < 0 || y1 >= nd.count || x1 >= nd.first.count
                nd[y1][x1] += 1
                flash(y1, x1, nd) if nd[y1][x1] > 9
            end
        end
    end

    def step
        nd = []
        (0...@data.count).each do |y|
            row = []
            nd << row
            (0...@data[y].count).each do |x|
                row << (@data[y][x] || 0) + 1
            end
        end

        (0...@data.count).each do |y|
            (0...@data.first.count).each do |x|
                flash(y, x, nd)
            end
        end

        (0...@data.count).each do |y|
            (0...@data[y].count).each do |x|
                nd[y][x] = 0 if nd[y][x] > 9
            end
        end

        Board.new(nd.map{|r| r.join("")}.join("\n"))
    end
end

class Solution
    def initialize(data)
        @boards = []
        @boards << Board.new(data)
    end

    def self.input
        File.read($0.gsub(/rb$/,'input'))
    end

    def self.part1
        board = Board.new(Solution.input)
        boards = []
        at_step = 0
        (1..100).each do |step|
            while at_step < step 
                board = board.step
                boards << board
                at_step += 1
            end
        end
        boards.map{|b| b.flashed.flatten.compact.sum}.sum
    end

    def self.part2
    end
end



puts "##### Solution #####"
puts "part1: #{Solution.part1}"
puts "part2: #{Solution.part2}"
puts "####################"
