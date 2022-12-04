#!/usr/bin/env ruby

require "pry"
require "active_support"
require "active_support/core_ext"

class AbstractSolution
  def initialize(data:)
    @data = data
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
