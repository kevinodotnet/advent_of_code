#!/usr/bin/env ruby

require 'pry'
require 'set'

def test_input
    <<EOF
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19
    
     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6
    
    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class Board
    def initialize(data)
        @data = data
        @played = []
    end
    def play(pick)
        @played << pick if @data.select{|d| d.include?(pick)}.any?
    end
    def empty_spots
        binding.pry
        @data.exclude(@played)
    end
    def won?
        (0..4).each do |rc|
            row = @data[rc]
            col = @data.map{|d| d[rc]}
            return row if row.all?{|r| @played.include?(r)}
            return col if col.all?{|r| @played.include?(r)}
        end
        false
    end
    def score
        return nil unless won?
        (Set.new(@data.flatten) - Set.new(@played)).sum
    end
end

class SolutionA
    def initialize(data)
        @data = parse(data)
    end
    def parse(data)
        lines = data.split("\n")
        lines = lines.map { |l| l.gsub(/^ */,'') }
        @picks = lines.shift.split(",").map { |i| i.to_i }
        lines.shift
        @boards = Set.new
        s_index = 0
        lines.each_with_index do |v, i|
            if v == ""
                @boards << Board.new(lines.slice(s_index, 5).map{|l| l.split(/  */).map{|d| d.to_i}})
                s_index = (i+1)
            end
        end
        @boards << Board.new(lines.slice(s_index, 5).map{|l| l.split(/  */).map{|d| d.to_i}})
    end
    def play(pick)
        @boards.each do |board|
            board.play(pick)
        end
    end
    def solve
        @picks.each_with_index do |pick, i|
            play(pick)
            winners = @boards.select{|b| b.won?}
            raise StandardError, "multiple winners" if winners.count > 1
            if winners.any?
                return winners.first.score * pick
            end
        end
        raise StandardError, 'No winners'
    end
end

class SolutionB < SolutionA
    def solve
        winners_by_round = []
        @picks.each_with_index do |pick, i|
            play(pick)
            winners = Set.new(@boards.select{|b| b.won?})
            winners_by_round << {
                pick: pick,
                winners: winners
            } if winners.any?
            @boards = @boards - winners
        end
        raise StandardError, "No single winner" unless winners_by_round.last[:winners].count == 1
        winner = winners_by_round.last[:winners].first
        pick = winners_by_round.last[:pick]
        winner.score * pick
    end
end

puts "#" * 100
puts "test: #{SolutionA.new(test_input).solve}"
puts "full: #{SolutionA.new(input).solve}"

puts "#" * 100
puts "test: #{SolutionB.new(test_input).solve}"
puts "full: #{SolutionB.new(input).solve}"