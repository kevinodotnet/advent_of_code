#!/usr/bin/env ruby

require "pry"
require "active_support"
require "active_support/core_ext"
require "benchmark"
require "matrix"

class AbstractSolution
  def initialize(data:)
    @data = data
  end
end

code_file = Dir["*"].select{|f| f.match(/^day_\d\d\.rb/)}.sort.last
test_file = code_file.gsub(/\.rb/, '_test.rb')
input_file = code_file.gsub(/\.rb/, '.input')

load code_file

if ARGV.last == "newday"
  newday = "%02d" % (code_file.match(/\d+/)[0].to_i + 1)
  FileUtils.cp("day_00.rb", "day_#{newday}.rb")
  FileUtils.cp("day_00_test.rb", "day_#{newday}_test.rb")
  FileUtils.touch("day_#{newday}.input")
elsif ARGV.last == "test"
  require "minitest/autorun"
  require "minitest/focus"
  load test_file
else
  solution = Solution.new(data: File.read(input_file))
  results = {}
  puts "#" * 100
  Benchmark.bm do |x|
    x.report(:part1) { results[:part1] = solution.part1 }
    x.report(:part2) { results[:part2] = solution.part2 }
  end
  puts "#" * 100
  puts results
  puts "#" * 100
end
