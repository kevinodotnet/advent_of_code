#!/usr/bin/env ruby

require 'pry'
require 'minitest/autorun'
require 'active_support/all'

def assert_equal(expected, actual)
  return if expected == actual
  puts "expected: #{expected}"
  puts "actual: #{actual}"
  raise StandardError
end

def input
  File.read('day_4.input').split("\n")
end

def test_input
  values = <<INPUT
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
INPUT
  values.split("\n")
end

class Passport
  attr_accessor :data
  def initialize(data)
    self.data = data.with_indifferent_access
  end

  REQUIRED = %w( byr iyr eyr hgt hcl ecl pid)
  VALID = REQUIRED + %w(cid)

  def valid?
    data.each do |k, v|
      return false unless VALID.include?(k)
    end
    REQUIRED.each do |k|
      return false unless data[k]
    end
    true
  end
end

class PassportScanner
  def self.parse_entry(data)
    entry = {}
    data.join(' ').split(' ').each do |kv|
      k, v = kv.split(':')
      entry[k] = v
    end
    Passport.new(entry)
  end

  def self.parse(data)
    db = []
    tmp = []
    data.each do |line|
      if line == ''
        if tmp.count > 0
          db << parse_entry(tmp)
          tmp = []
        end
        next
      end
      tmp << line
    end
    db << parse_entry(tmp) if tmp.count > 0
    db
  end
end

def part1
  db = PassportScanner.parse(test_input)
  assert_equal 2, db.select{|p| p.valid?}.count
  db = PassportScanner.parse(input)
  puts "part1 answer: #{db.select{|p| p.valid?}.count}"
end
#part1

class Passport
  def between_incl?(val, low, high)
    val = val.to_i
    return val >= low && val <= high
  end

  def valid2?
    return false unless valid?
    #byr (Birth Year) - four digits; at least 1920 and at most 2002.
    if data['byr']
      return false unless between_incl?(data['byr'], 1920, 2002)
    end
    #iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    if data['iyr']
      return false unless between_incl?(data['iyr'], 2010, 2020)
    end
    #eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    if data['eyr']
      return false unless between_incl?(data['eyr'], 2020, 2030)
    end
    #hgt (Height) - a number followed by either cm or in:
    #If cm, the number must be at least 150 and at most 193.
    #If in, the number must be at least 59 and at most 76.
    if data['hgt']
      if match_data = data['hgt'].match(/^(\d+)cm$/)
        return false unless between_incl?(match_data[1], 150, 193)
      elsif match_data = data['hgt'].match(/^(\d+)in$/)
        return false unless between_incl?(match_data[1], 59, 76)
      else
        return false
      end
    end
    #hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    if data['hcl']
      return false unless data['hcl'].match(/^#[0-9a-f]{6,6}*$/)
    end
    #ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    if data['ecl']
      return false unless %w(amb blu brn gry grn hzl oth).include?(data['ecl'])
    end
    #pid (Passport ID) - a nine-digit number, including leading zeroes.
    if data['pid']
      return false unless data['pid'].match(/^[0-9]{9,9}$/)
    end
    #cid (Country ID) - ignored, missing or not.
    true
  end
end

def part2
  [
  'eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926',
  'iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946',
  'hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277',
  'hgt:59cm ecl:zzz eyr:2038 hcl:74454a iyr:2023 pid:3556412378 byr:2007',
  ].each do |line|
    assert_equal false, PassportScanner.parse([line]).first.valid2?
  end

  [
  'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f',
  'eyr:2029 ecl:blu cid:129 byr:1989 iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm',
  'hcl:#888785 hgt:164cm byr:2001 iyr:2015 cid:88 pid:545766238 ecl:hzl eyr:2022',
  'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719',
  ].each do |line|
    assert_equal true, PassportScanner.parse([line]).first.valid2?
  end

  db = PassportScanner.parse(input)
  puts "part2 answer: #{db.select{|p| p.valid2?}.count}"
end

#class PassportTest < Minitest::Test
#  def test_valid2
#    assert Passport.new(byr: '2002').valid2?
#    refute Passport.new(byr: '2003').valid2?
#
#    assert Passport.new(hgt: '60in').valid2?
#    assert Passport.new(hgt: '190cm').valid2?
#    refute Passport.new(hgt: '190in').valid2?
#    refute Passport.new(hgt: '190').valid2?
#
#    assert Passport.new(hcl: '#123abc').valid2?
#    refute Passport.new(hcl: '#123abz').valid2?
#    refute Passport.new(hcl: '123abc').valid2?
#
#    assert Passport.new(ecl: 'brn').valid2?
#    refute Passport.new(ecl: 'wat').valid2?
#
#    assert Passport.new(pid: '000000001').valid2?
#    refute Passport.new(pid: '0123456789').valid2?
#  end
#end

part1
part2
