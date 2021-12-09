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
                digits: digits
            }
        end
    end
    def solve_pattern(p, count_of)
        #     0:      1:      2:      3:      4:
        #     aaaa    ....    aaaa    aaaa    ....
        #    b    c  .    c  .    c  .    c  b    c
        #    b    c  .    c  .    c  .    c  b    c
        #     ....    ....    dddd    dddd    dddd
        #    e    f  .    f  e    .  .    f  .    f
        #    e    f  .    f  e    .  .    f  .    f
        #     gggg    ....    gggg    gggg    ....
        
        #      5:      6:      7:      8:      9:
        #     aaaa    aaaa    aaaa    aaaa    aaaa
        #    b    .  b    .  .    c  b    c  b    c
        #    b    .  b    .  .    c  b    c  b    c
        #     dddd    dddd    ....    dddd    dddd
        #    .    f  e    f  .    f  e    f  .    f
        #    .    f  e    f  .    f  e    f  .    f
        #     gggg    gggg    ....    gggg    gggg

        # DIGITS.map{|k,v| { k: k, v: v.count}}
        # {:k=>:d1, :v=>2},
        # {:k=>:d7, :v=>3},
        # {:k=>:d4, :v=>4},
        # {:k=>:d8, :v=>7},
    
        mapping = {} # wrong segment to correct segment
        segments = {} # by digit, the segments that are actually lit up

        # 1 overlaps with 7, the extra one in :d7 is thus :a
        segments[:d1] = p[:samples].detect{|s| s.count == 2}
        segments[:d4] = p[:samples].detect{|s| s.count == 4}
        segments[:d7] = p[:samples].detect{|s| s.count == 3}
        segments[:d8] = p[:samples].detect{|s| s.count == 7}

        # d7 and d4 differ by :a only, so we can map
        mapping[:a] = (segments[:d7] - segments[:d1]).first

        # use 5 segment digits to isolate :g
        f = segments[:d8].dup
        p[:samples].select{|s| s.count == 5}.each{|s| f = f & s}
        f = f - Set.new([mapping.invert[:a]]) # remove :a leaving only :d:g
        mapping[:g] = (f - segments[:d4]).first # use :d4 to remove :d, leaving :g

        # the union of [:d2, :d3, :d5] is [a/d/g]; then union D4 to isolate :d
        # {:k=>:d2, :v=>5},
        # {:k=>:d3, :v=>5},
        # {:k=>:d5, :v=>5},
        mapping[:d] = (p[:samples].select{|s| s.count == 5}.inject(DIGITS[:d8].dup){|f, s| f&s} & DIGITS[:d4]).first

        # 7 and 4 is [:b, :d]
        bd = (segments[:d4] - segments[:d7]).to_a
        # only :d5 has [b,d] and also a count of 5
        segments[:d5] = p[:samples].select{|s| s.include?(bd.first) && s.include?(bd.last) && s.count == 5}.first
        
        # now can isolate :f, then :c
        mapping[:f] = (segments[:d5] & segments[:d1]).first
        mapping[:c] = (segments[:d1] - Set.new([mapping[:f]])).first

        segments[:d3] = p[:samples].select{|s| s.count == 5 && s != segments[:d5] && s.include?(:f)}.first
        segments[:d2] = p[:samples].select{|s| s.count == 5 && s != segments[:d5] && s.include?(:e)}.first

        segments[:d6] = segments[:d8] - Set.new([mapping[:c]])

        segments[:d0] = p[:samples].select{|s| s.count == 6 && s != segments[:d6] && !s.include?(mapping[:d])}.first
        segments[:d9] = p[:samples].select{|s| s.count == 6 && s != segments[:d6] && s.include?(mapping[:d])}.first

        # In the output values, how many times do digits 1, 4, 7, or 8 appear?
        r = p[:digits].map do |d|
            count_of.include?(segments.invert[d]) ? 1 : 0
        end.sum
        r
    end
    def solve(count_of)
        @patterns.map do |p|
            solve_pattern(p, count_of)
        end.sum
    end
end

class SolutionB < SolutionA
end

class SolutionATest < Minitest::Test
    def test_unscrambled
        all = SolutionA::DIGITS.values.map{|s| s.to_a.join("")}
        input = [all, "|", all].join(" ")
        assert_equal 1, SolutionA.new(input).solve([:d0])
    end
    def test_digits_constant
        assert_equal SolutionA::DIGITS.values.uniq.count, SolutionA::DIGITS.count
    end
    def test_the_test_input_1
        assert_equal 26, SolutionA.new(test_input_2).solve([:d1, :d4, :d7, :d8])
    end
end

class SolutionBTest < Minitest::Test
    def test_the_test_input
    end
end

puts "##### Solution A #####"
puts "full: #{SolutionA.new(input).solve([:d1, :d4, :d7, :d8])}
# puts "##### Solution B #####"
# puts "test: #{SolutionB.new(test_input).solve}"
# puts "full: #{SolutionB.new(input).solve}"
