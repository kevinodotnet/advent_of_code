#!/usr/bin/env ruby

require 'pry'

def assert_equal(expected, actual)
  return if expected == actual
  puts "expected: #{expected}"
  puts "actual: #{actual}"
  raise StandardError
end

def input
  values = <<INPUT
.#..............##....#.#.####.
##..........#.....##...........
.......#....##...........#.#...
.........#.#...#..........#....
.........#..#................##
..#...#..#..#...........#......
...................#...##..##..
........#.....##...#.#.#...#...
#..#.##......#.#..#..........#.
......#.#...#.#...#........##.#
.....#.####........#...........
...###..#............#.........
.....#.......##......#...#.....
#......##......................
......#..............#.........
..##...#....###.##.............
#...#..........#.#.........#...
...........#........#...#......
.....##.........#......#..#....
#..............#....#.....#....
.#......#....#...#............#
.####..........##..#.#.........
....#...#......................
....................#....#.#...
..........###.#...............#
.#...........#...##............
.#.#..#.....#...#....#.......#.
.##........#..#....#...........
.........#.....#......###......
..............#..#.......#.....
........#..#.#...........#..#..
#.........#......#.....##.#.#..
........#.#.#....#.............
........#........#.#.##........
#......#.#..........#..#.......
..#....#...##......###..#..#...
............#..#.#.........#...
....#.#...........#..........##
.......#.#.#..#......#...#.....
..#.........##.#.........#...#.
......#....#.#....#........#.#.
.#....###....#..............#..
.#....#.......#....#..#.....#..
.....#.....#...................
..#.....#......#......#........
......##.##...#...#...#...#.##.
##...#....#...#..#...#...#.....
..#.....#...#...##.##...#......
.....#.............##...#......
.....................#.##..#...
#...#....#....#........#.....#.
..#...#.........#...#..#.....#.
#.#......#...................#.
..#...........##...............
..#....#........#..#...........
...........#...................
.............###......#....#...
...........#...#....#..#....#..
.....##............#.#.......#.
.....#..#....#...#....#........
...............##........#.#...
.........#...#.#....#.......#..
#..#.......#.......#...#.......
..#...........................#
......#.......#..#......#......
.#.......#..................##.
..#.........#..#.##.#....#...##
...#..#....#...#....#.#........
.#...#........##..#..#.......#.
.....#........#....#....#..#...
............#...........#......
..###.......#..#....#......#...
.....#...#.......#..#..........
..#........##.#....##..........
#....#.............#..##......#
....#.................##.......
...#.......#........#....##.#.#
##..##..#.....#.....#..........
...#...............#....#..#...
.#...##....#....#.....#....##..
...#.....#......#......#.......
#.....#.......##.....#..#....##
.....#.#...##.#......##....#.#.
..........#....#.#...#.........
.#..##...#.....................
...........##..#...#....#......
...#......#........#.......#...
.#......#..#........#.....#..#.
.......#........##..#.##....#..
.##..........#..#...#.....#....
.....##...............#.#......
..##.....#..#......#..##.#.#...
....#......#.##...........#....
#.#..#.......#......#.#........
...#.#..#....#............#..#.
...#..........###....#....#...#
........##...#.......#..#....#.
..#...#.....#..#........##.....
...#..#.##.#.#.##..............
.......#...#.........#.....#..#
..#.....#.#..........#..#......
......#..........#......#.....#
.#...........#........#......##
..##............#......#...#..#
#..................#...........
#....#..#.........#........#..#
..#.#....###..#...#...##...##..
...#....#..#.....#.............
.#........##.##...#....#...#...
.........#.......##.#.....##...
#.#.....##...#........#...#...#
.....#.#.##...#.....#.##..#....
........#...##...#...#.#..#..#.
.##....#.##...#.......#........
...#..#................#..#....
....#.......#......#...#.##....
#......###..#...#......#.......
..#...#...##...........##......
.......#...#..##....##......#..
....#.#.............#.#...##..#
..........#........#...#......#
............#.#.#....###.......
#..#...#.#.####...#..#...#.....
.##.......#.##...#.............
#..#...........#.#.##.......#..
...#..#.#...#...###..#.#..#.#..
..#...#.....#..#....#....#.....
.........##.......#............
.........##.##......###........
.............#.#....#..#.....#.
...#....#.#.......#......##....
............#..................
....##...#..........#...#..#...
#..#....#.....#.......#.##.#..#
.....#.........##.............#
#.....#.#...#............##..##
..............#....#.....#.....
.#....###..#.#.....###.#..#....
.....#....##...#....#......#...
..........#...#....#...........
............#....#..#.........#
..##.....#.#...#.......#...#...
...#...#..#......##...#.....##.
......#.##............##.#....#
....#......#...##.....#.....###
.#.###...............#...#.#...
..#....................##...#..
.......#.....##...........#....
#.........#....#....#....#....#
..#.#..##.#.#..................
.....#.......#................#
...........#.......#........#..
#...#.........#.#.....#.....#..
..........#..#...........#.....
#..#.##..##..#.#.##.........#..
#..#..#....##..#.........#.....
#.#.......................#.#..
.##......#.#...#......#....#...
..#.#................#..##.....
.......#..................#...#
.....#.........##.#....#.......
#..........#..#.#..........#..#
..#..#.....#.........#...#.....
..............#.....#..#...#.##
...............................
...#............##......#.....#
.......#..#.............#.#....
...........#..........#........
...#.####..#......#...#....#...
##......#.##.....#.............
....#.........#...#...........#
...#........#.......#.#..#.#.#.
..#.......#.........#....#.....
................#.#.#.##...#..#
#.##...#...#..#.....#.....#..#.
...............#...........#...
.....##.#...............##...#.
.#..##.##......................
.......#.........#..#..#.......
...#......#..................#.
...#.#..#....#....#............
...........#...#..#....##......
.....#...#..#.#....#....#....#.
.......#...#...#.#.#...........
....#......#......#...##..#....
##...#.#.....#..#.##...........
#.#..#.....#..#................
...#..#.#......#.#...........##
##....#...#.....###..#...#....#
...#.....#.#.#......##...#...#.
............#.......#..........
....#..........###.......#.....
.................##..##....#...
...........#........##..#......
...#.#...#.....#........#...#..
#...#.#......#.#...........#...
..#..........#....#..........#.
..#................#...........
#...#.#....#.#.......#.........
.#...........##..#....#....#..#
.##........#.....#...#..#....#.
......#......#...#.............
.......#..#...#.##....#..#.#...
.......#......#....#....#.#.#..
..........##.....#....##.#.....
.........##..#...#.....#..#....
...#....#..........#..#...#..#.
.......#.....##.#..#.....#...#.
#...#......#......#...#........
#..#....#.#......#......#......
.......#.##....................
...##...#.....#......##......#.
.#...................###.......
....#........###...#........#..
...#............#.....#..#.....
..................#......#....#
..##......#..##..##......#.#...
........##....##.......#...#...
.#.#....#.....#.....#....#....#
...##.#.............#....##....
.........#.....#...#......#....
..#.....#............#....##...
..##.....#.....##.##...........
#....#.#.......#..#......#.....
##.......#.....#.....####....#.
##...#.......#...#.....#.......
#.....#..##.##...##..#.....#..#
..........#......#..#.#........
..##.#......#..............#...
.#...#..........#.......#....#.
..#....##...#...........#....#.
..#.........#..#......#......#.
.##....#......#.#.........#..##
.......#...#....##............#
.##.................#.#........
...#.#...#..#..#.....#.#.......
.#.#.......#...................
..#..#.....#......#.....##..##.
.#........#.##......#..........
....##...#............#.#....#.
.......#.#..#....##.#....#....#
......####...#..#.....#........
..........#..#.........#.#..#.#
..........##.........#.##......
.##..#.#.....#.....#....#......
............#..#...............
.....##.........#...#...##...##
........#.##.#...#.....#....#.#
#......##.#.##..........##.....
#..#..#........#.........#..#..
...............#.#..##.........
.#.......##.#..#....#...#....##
.#..##.....##......#....#...#.#
........#...#.........#.....#.#
...........#............#...#..
................#...........#..
..............##........#....#.
..........#.....##.....#..#....
#......#....###..#..#..........
.....#.#.....##....#.#.......#.
...#...#...............#.#.....
.............#.......#.........
.....#.....#..#......#.....#...
.........#.................#.##
.#.....#.##..#.................
..#......#.......#.....#...#..#
..#..#.#.#...#.......#.##......
..........#..#.........#.......
.#..........#...#....#..#...##.
.#.#.#.###.....#...#.#.#.......
....##............#............
.#.#.............#..#......#.#.
.#.#..........##..#.....#..#.#.
...........#.##..#...#.#.....#.
...........#..#....#...........
..#................#.#...#....#
...............##........##....
....#.............#........#...
...#......#.#.#........#.......
#..............#..##.#..##.....
.#.#.###................##.....
.............#..#.........#....
.......##..#............#...#..
...#...#...........#.....#.....
........#......#.#.#......#..#.
#.##.......#......#..#..#.#....
...#........#...........#...#..
..#...........#.........#......
.............#....#....#.......
....#.........#........#......#
..#............##..#.........#.
.#...#...#..#...#........#..#..
...#....##..............#......
...........#...#....#.#.##..###
..#....#......#.........#..#...
.......#...#...................
.#...#.#...................#...
.#.....##.#.......#.#.#...##..#
.....#..#.#.........#...#..##..
.#..#.##.#......#......#.#...#.
......#..#....##..#....##....##
#...#......##........##........
.#.........###................#
.................#..###..#.#...
..#.#........#..#........#...#.
#.#....#....#..#...#.#......#..
.#.#.............###.........#.
.....#...............##...#...#
..............#...#........#..#
...................#..#.......#
#......................#.....#.
...#.........#..##...#...#.##..
.....#..........#.........#....
.....#...#............#..#.....
.............#............#....
...#.........#.................
#...........#.#...............#
.....#...#.....#..#.##.......##
...#....#.#...........#........
.........................#.#...
.#..#...........#.#........#...
.............#.#.....#..#....#.
.....#...#.###...#..#........#.
INPUT
  values.split("\n")
end


def test_input
  values = <<INPUT
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
INPUT
  values.split("\n")
end

class Hill
  attr_accessor :data
  def initialize(data)
    self.data = data
  end

  def tree?(row, col)
    data[row].chars[col % data.first.chars.count] == '#'
  end

  def rows
    data.count
  end

  def to_s
    data.each do |row|
      puts (row + '|') * 4
    end
  end

  def trees_hit(right:, down: )
    position = [0, 0] # row, col
    tree_count = 0
    while position[0] < rows do
      tree_count += 1 if tree?(position[0], position[1])
      position[0] += down
      position[1] += right
    end
    tree_count
  end
end

hill = Hill.new(['..##'])
assert_equal false, hill.tree?(0,0)
assert_equal false, hill.tree?(0,1)
assert_equal true, hill.tree?(0,2)
assert_equal true, hill.tree?(0,3)
assert_equal false, hill.tree?(0,4+0)
assert_equal false, hill.tree?(0,4+1)
assert_equal true, hill.tree?(0,4+2)
assert_equal true, hill.tree?(0,4+3)

hill = Hill.new(test_input)
assert_equal 7, hill.trees_hit(right: 3, down: 1)

def part1
  puts "part1 answer"
  hill = Hill.new(input)
  puts hill.trees_hit(right: 3, down: 1)
end

def part2
  hill = Hill.new(test_input)
  trees = []
  slopes = [
    { right: 1, down: 1 },
    { right: 3, down: 1 },
    { right: 5, down: 1 },
    { right: 7, down: 1 },
    { right: 1, down: 2 }
  ]

  slopes.each do |dir|
    trees << hill.trees_hit(right: dir[:right], down: dir[:down])
  end

  assert_equal [2,7,3,4,2], trees
  assert_equal 336, trees.reject(&:zero?).inject(:*)

  hill = Hill.new(input)
  trees = []
  slopes.each do |dir|
    trees << hill.trees_hit(right: dir[:right], down: dir[:down])
  end

  puts "part2 answer"
  puts trees.reject(&:zero?).inject(:*)
end

part1
part2

