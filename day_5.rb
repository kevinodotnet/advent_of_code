#!/usr/bin/env ruby

require 'pry'
require 'minitest/autorun'
require 'active_support/all'

def input
  File.read('day_5.input').split("\n")
end

def test_input
  values = <<INPUT
INPUT
  values.split("\n")
end

class SeatScanner
  def self.parse(data)
    delta = 64
    row = 0
    data.chars.first(7).each do |c|
      step = (c == 'F' ? 0 : delta)
      row += step
      delta /= 2
    end

    col = 0
    delta = 4
    data.chars.last(3).each do |c|
      step = (c == 'L' ? 0 : delta)
      col += step
      delta /= 2
    end
    {
      row: row,
      col: col,
      seat_id: (row * 8) + col
    }
  end
end

class Day5Test < Minitest::Test
  def test_foo
    result = SeatScanner.parse('FBFBBFFRLR')
    assert_equal 44, result[:row]
    assert_equal 5, result[:col]

    result = SeatScanner.parse('BFFFBBFRRR')
    expected = {row: 70, col: 7, seat_id: 567}
    assert_equal expected, result

    result = SeatScanner.parse('FFFBBBFRRR')
    expected = {row: 14, col: 7, seat_id: 119}
    assert_equal expected, result

    result = SeatScanner.parse('BBFFBBFRLL')
    expected = {row: 102, col: 4, seat_id: 820}
    assert_equal expected, result
  end
end

seats = input.map do |line|
  seat = SeatScanner.parse(line)
end

# What is the highest seat ID on a boarding pass?
puts "#" * 100
puts "Part 1 answer: "
puts seats.sort_by { |hsh| hsh[:seat_id] }.last[:seat_id]
puts "#" * 100

puts "#" * 100
puts "Part 2 answer: "
seats = seats.sort_by { |hsh| hsh[:seat_id] }
seats.each_with_index do |s, i|
  next if i == 0
  seat_id1 = seats[i-1][:seat_id]
  seat_id2 = seats[i][:seat_id]
  puts "seat_id: #{seat_id2-1}" if (seat_id2 - seat_id1 != 1)
end
puts "#" * 100

