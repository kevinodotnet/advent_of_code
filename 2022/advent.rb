#!/usr/bin/env ruby

require "pry"

class AbstractSolution
  def initialize(data:)
    @data = data
  end

  def parse
    @data.split("\n")
  end

  def part1
  end

  def part2
  end
end

code_file = Dir["*"].select{|f| f.match(/^day_\d\d\.rb/)}.sort.last
test_file = code_file.gsub(/\.rb/, '_test.rb')
input_file = code_file.gsub(/\.rb/, '.input')

load code_file

if ARGV.last == "test"
  require "minitest/autorun"
  require "minitest/focus"
  load test_file
else
  solution = Solution.new(data: File.read(input_file))
  puts "#" * 100
  puts "Part1: #{solution.part1}"
  puts "Part2: #{solution.part2}"
  puts "#" * 100
end
