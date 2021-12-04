#!/usr/bin/env ruby

require 'pry'

def test_input
    <<EOF.split("\n")
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
EOF
end

def input
    File.read($0.gsub(/rb$/,'input')).split("\n")
end

class SolutionA
    def initialize(data)
        @data = parse(data)
    end
    def parse(data)
        data.map do |d|
            d.split('').map{|i| i.to_i}
        end
    end
    def gamma_rate
        r = (0...@data.first.count).map do |i|
            r = @data.map do |v|
                v[i]
            end
            c0 = r.select{|i| i == 0}.count
            c1 = r.select{|i| i == 1}.count
            c0 >= c1 ? 0 : 1
        end
        r.join('').to_i(2)
    end
    def epsilon_rate
        r = (0...@data.first.count).map do |i|
            r = @data.map do |v|
                v[i]
            end
            c0 = r.select{|i| i == 0}.count
            c1 = r.select{|i| i == 1}.count
            c0 >= c1 ? 1 : 0
        end
        r.join('').to_i(2)
    end
    def solve
        gamma_rate * epsilon_rate
    end
end

class SolutionB < SolutionA
    def most_common_at(data, i, default)
        r = data.map{|d| d[i]}
        c0 = r.select{|i| i == 0}.count
        c1 = r.select{|i| i == 1}.count
        return default if c0 == c1
        c0 > c1 ? 0 : 1
    end
    def least_common_at(data, i, default)
        r = most_common_at(data, i, nil)
        return default if r.nil?
        r == 0 ? 1 : 0
    end
    def oxygen
        result = @data.dup
        (0...@data.first.count).each do |i|
            next if result.count == 1
            result = result.select{|d| d[i] == most_common_at(result, i, 1)}
        end
        result = result.first
        result.join('').to_i(2)
    end
    def co2_scrubber
        result = @data.dup
        (0...@data.first.count).each do |i|
            next if result.count == 1
            least_common = least_common_at(result, i, 0)
            result = result.select{|d| d[i] == least_common}
        end
        result = result.first
        result.join('').to_i(2)
    end
    def solve
        oxygen * co2_scrubber
    end
end

puts "#" * 100
puts "test: #{SolutionA.new(test_input).solve}"
puts "full: #{SolutionA.new(input).solve}"

puts "#" * 100
puts "test: #{SolutionB.new(test_input).solve}"
puts "full: #{SolutionB.new(input).solve}"