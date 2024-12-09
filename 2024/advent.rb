#!/usr/bin/env ruby

# bundle exec ./advent.rb

require "active_support"
require "active_support/core_ext"
require "benchmark"
require "pry"
require "rgl/adjacency"
require "rgl/dijkstra"

class AbstractSolution
  def initialize(data:)
    @data = data
    parse
  end
end

code_file = ARGV.first

if code_file == "newday"
  code_file = Dir["*"].select{|f| f.match(/^day_\d\d\.rb/)}.sort.last
  newday = "%02d" % (code_file.match(/\d+/)[0].to_i + 1)
  FileUtils.cp("day_00.rb", "day_#{newday}.rb")
  FileUtils.cp("day_00_test.rb", "day_#{newday}_test.rb")
  FileUtils.touch("day_#{newday}.input")
else
  code_file ||= Dir["*"].select{|f| f.match(/^day_\d\d\.rb/)}.sort.last
  test_file = code_file.gsub(/\.rb/, '_test.rb')
  require "minitest/autorun"
  require "minitest/focus"
  load code_file
  load test_file
end
