#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

def test_input_1
    <<~EOF
    acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
    EOF
end

def test_input_2
    <<~EOF
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class SolutionA
    attr_accessor :patterns
    DIGITS = {
        d0: Set.new("abcefg".split("").map{|s| s.to_sym}),
        d1: Set.new("cf".split("").map{|s| s.to_sym}),
        d2: Set.new("acdeg".split("").map{|s| s.to_sym}),
        d3: Set.new("acdfg".split("").map{|s| s.to_sym}),
        d4: Set.new("bcdf".split("").map{|s| s.to_sym}),
        d5: Set.new("abdfg".split("").map{|s| s.to_sym}),
        d6: Set.new("abdefg".split("").map{|s| s.to_sym}),
        d7: Set.new("acf".split("").map{|s| s.to_sym}),
        d8: Set.new("abcdefg".split("").map{|s| s.to_sym}),
        d9: Set.new("abcdfg".split("").map{|s| s.to_sym}),
    }
    def initialize(data)
        @patterns = data.split("\n").map do |line|
            samples = line.gsub(/ \|.*/,'').split(" ").map do |s|
                Set.new(s.split("").map{|s| s.to_sym})
            end
            digits = line.gsub(/.* \| /,'').split(" ").map do |d|
                Set.new(d.split("").map{|d| d.to_sym})
            end
            {
                samples: samples,
                digits: digits,
                result: solve_pattern(samples, digits)
            }
        end
    end

    def solve_pattern(samples, digits)
        mapping = {}
        segments = {}
        p = {
            samples: samples,
            digits: digits
        }

        segments[:d1] = samples.detect{|s| s.count == 2}
        segments[:d4] = samples.detect{|s| s.count == 4}
        segments[:d7] = samples.detect{|s| s.count == 3}
        segments[:d8] = samples.detect{|s| s.count == 7}
        segments.values.each{|s| samples = samples - [s]}

        # use d4/7 to isolate :a
        mapping[:a] = (segments[:d7] - segments[:d1]).first

        # d:9 == samples with count 6 that have only one diff.count from :d4
        samples.select do |s|
            next unless s.count == 6
            remaining = (s - segments[:d4] - Set.new([mapping[:a]]))
            next unless remaining.count == 1
            segments[:d9] = s
            raise StandardError if mapping[:g]
            mapping[:g] = remaining.first
        end
        segments.values.each{|s| samples = samples - [s]}

        # diff of :d & d:9 is :e
        mapping[:e] = (segments[:d8] - segments[:d9]).first
        d06 = samples.select{|s| s.count == 6}

        # diff of d06; then minute :d1, yeilds :e
        mapping[:d] = [d06.first - d06.last - segments[:d1], d06.last - d06.first - segments[:d1]].select{|a| a.count == 1}.first.first
        raise StandardError unless d06.count == 2
        d06.map do |d|
            if (d + Set.new([mapping[:d]])).count == 7
                # we found :d0
                segments[:d0] = d
            else
                segments[:d6] = d
            end
        end

        d235 = samples.select{|s| s.count == 5}

        # get d2
        mapped = Set.new(mapping.values)
        d35 = nil
        d235.each do |d| 
            next unless (d - mapped).count == 1
            mapping[:c] = (d - mapped).first
            segments[:d2] = d
            d35 = d235 - [d]
        end

        mapped = Set.new(mapping.values)
        d35.each do |d| 
            next unless (d - mapped).count == 1
            mapping[:f] = (d - mapped).first
            segments[:d3] = d
            segments[:d5] = (d35 - [d]).first
        end

        mapping[:b] = (segments[:d8] - Set.new(mapping.values)).first

        out_digits = digits.map do |d|
            segments.invert[d].to_s.gsub('d','')
        end.join('')

        return {
            segments: segments,
            mapping: mapping,
            digits: out_digits
        }
    end
    def solve
        @patterns.map{|p| p[:result][:digits].to_i}.sum
    end
end

class SolutionB < SolutionA
end

class SolutionATest < Minitest::Test
    def test_unscrambled
        all = SolutionA::DIGITS.values.map{|s| s.to_a.join("")}
        input = [all, "|", all].join(" ")
        s = SolutionA.new(input)
        assert_equal 10, s.patterns.first[:result][:segments].count
        assert_equal 7, s.patterns.first[:result][:mapping].count
        assert_equal "0123456789", s.patterns.first[:result][:digits]
    end
    def test_part_2
        s = SolutionA.new(test_input_1)
        assert_equal 10, s.patterns.first[:result][:segments].count
        assert_equal 7, s.patterns.first[:result][:mapping].count
        assert_equal "5353", s.patterns.first[:result][:digits]
    end
    def test_part_2_input_2
        s = SolutionA.new(test_input_2)
        expected = ["8394","9781","1197","9361","4873","8418","4548","1625","8717","4315"]
        assert_equal expected, s.patterns.map{|p| p[:result][:digits]}
    end
end

puts "##### Solution A #####"
puts "full: #{SolutionA.new(input).solve}"
