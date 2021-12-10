#!/usr/bin/env ruby

# bundle exec ./day_XX.rb

require 'pry'
require 'set'
require 'minitest/autorun'
require 'minitest/focus'

def test_input
    <<~EOF
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    EOF
end

def input
    File.read($0.gsub(/rb$/,'input'))
end

class ParseError < StandardError
    attr_reader :illegal_char
    def initialize(message, illegal_char: nil)
        super(message)
        @illegal_char = illegal_char
    end
end
class UnexpectedSymbol < ParseError; end
class UnclosedChunk < ParseError; end

class Chunk 
    attr_reader :parent, :index, :children, :autocomplete
    def initialize(parent, index)
        @parent = parent
        @index = index
        @children = []
        @autocomplete = []
        parent.append_child(self) if parent
    end
    def append_child(child)
        @children << child
    end
    def flatten_autocomplete
        [children.map{|c| c.flatten_autocomplete}, autocomplete].flatten
    end
end

class Solution
    CHUNK_DELIMS = [
        '()',
        '[]',
        '{}',
        '<>'
    ]
    CHUNK_OPEN = CHUNK_DELIMS.map{|d| d[0]}
    CHUNK_CLOSE = CHUNK_DELIMS.map{|d| d[1]}
    def self.closing_for(c)
        raise ParseError.new("not an opening character: #{c}") unless CHUNK_OPEN.include?(c)
        CHUNK_DELIMS.detect{|d| d[0] == c}[1]
    end
    def self.parse(data)
        root = Chunk.new(nil,-1)
        chunks = [root]
        data.each_char.with_index do |c, i|
            if CHUNK_OPEN.include?(c)
                chunk = Chunk.new(chunks.last, i)
                chunks << chunk
            elsif CHUNK_CLOSE.include?(c)
                raise ParseError.new("Unexpected bracklet closure at #{i}") unless chunks.last
                chunk = chunks.pop
                expected = closing_for(data[chunk.index])
                raise UnexpectedSymbol.new("Expected #{expected}, but found #{c} instead.", illegal_char: c) unless expected == c
            end
        end
        while chunks.length > 1
            chunk = chunks.pop
            chunk.autocomplete << closing_for(data[chunk.index])
        end
        raise UnclosedChunk.new('unclosed') if chunks.length > 1
        root
    end
    def part1(data)
        points = {
            ")" => 3,
            "]" => 57,
            "}" => 1197,
            ">" => 25137
        }
        total = 0
        data.chomp.split("\n").each do |line|
            begin
                root = Solution.parse(line)
            rescue UnexpectedSymbol => e
                total += points[e.illegal_char]
            rescue UnclosedChunk => e
            end
        end
        total
    end
    def part2(data)
        points = {
            ")" => 1,
            "]" => 2,
            "}" => 3,
            ">" => 4
        }
        scores = data.chomp.split("\n").map do |line|
            begin
                root = Solution.parse(line)
                root.flatten_autocomplete.inject(0){|score, c| score *= 5; score += points[c]; score}
            rescue UnexpectedSymbol => e
                # ignore
            end
        end
        scores = scores.compact.sort
        scores[scores.count/2]
    end
end

class SolutionTest < Minitest::Test
    def test_parse
        root = Solution.parse('()')
        assert_equal 1, root.children.length
        root = Solution.parse('[]')
        assert_equal 1, root.children.length
        root = Solution.parse('{}')
        assert_equal 1, root.children.length
        root = Solution.parse('<>')
        assert_equal 1, root.children.length
        root = Solution.parse('<()>')
        assert_equal 1, root.children.length
        assert_equal 1, root.children.first.children.length
        assert_equal 0, root.children.first.children.first.children.length
        root = Solution.parse('{}{}')
        assert_equal 2, root.children.length
    end
    def test_parse_errors
        assert_raises ParseError do Solution.parse('>'); end
        assert_raises ParseError do Solution.parse('(]'); end
        assert_raises ParseError do Solution.parse('{()()()>'); end
        assert_raises ParseError do Solution.parse('(((()))}'); end
        assert_raises ParseError do Solution.parse('<([]){()}[{}])'); end
    end
    def test_parses_errors_more
        expected = {
            "{([(<{}[<>[]}>{[]{[(<()>" => "Expected ], but found } instead.",
            "[[<[([]))<([[{}[[()]]]" => "Expected ], but found ) instead.",
            "[{[{({}]{}}([{[{{{}}([]" => "Expected ), but found ] instead.",
            "[<(<(<(<{}))><([]([]()" => "Expected >, but found ) instead.",
            "<{([([[(<>()){}]>(<<{{" => "Expected ], but found > instead."
        }
        expected.each do |k, v|
            e = assert_raises ParseError do
                Solution.parse(k)
            end
            assert_equal v, e.message
        end
    end
    def test_autocomplete
        expected = {
            "[" => "]",
            "[(" => ")]",
            "[({(<(())[]>[[{[]{<()<>>" => "}}]])})]",
            "[(()[<>])]({[<{<<[]>>(" => ")}>]})",
            "(((({<>}<{<{<>}{[]{[]{}" => "}}>}>))))",
            "{<[[]]>}<{[{[{[]{()[[[]" => "]]}}]}]}>",
            "<{([{{}}[<[[[<>{}]]]>[]]" => "])}>",
        }
        expected.each do |k, v|
            root = Solution.parse(k + v)
            assert_equal '', root.flatten_autocomplete.join('')
            root = Solution.parse(k)
            assert_equal v, root.flatten_autocomplete.join('')
        end
    end
    def test_part1
        assert_equal 26397, Solution.new.part1(test_input)
    end
    def test_part2
        assert_equal 288957, Solution.new.part2(test_input)
    end
end

puts "##### Solution #####"
puts "part1: #{Solution.new.part1(input)}"
puts "part2: #{Solution.new.part2(input)}"
puts "####################"
