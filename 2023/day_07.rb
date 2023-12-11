class Hand
  include Comparable

  attr :cards, :orig

  CARD_ORDER = [
    "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"
  ]

  TYPE_ORDER = [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :full_house,
    :four_of_a_kind,
    :five_of_a_kind
  ]

  def initialize(cards)
    @orig = cards.dup
    @cards = cards.sort{|a, b| card_strength(b) <=> card_strength(a) }
  end

  def <=>(other)
    if type_strength == other.type_strength
      self_strengths = orig.map{|c| card_strength(c)}
      other_strengths = other.orig.map{|c| card_strength(c)}
      self_strengths.each_with_index do |s, i|
        o = other_strengths[i]
        next if s == o
        return s <=> o
      end
      binding.pry # bad
    else
      type_strength <=> other.type_strength
    end
  end

  def inspect
    "Hand: #{hand_type} #{@cards.join("")} orig: #{@orig.join("")}"
  end

  def card_strength(card)
    CARD_ORDER.index(card)
  end

  def type_strength
    TYPE_ORDER.index(hand_type)
  end

  def hand_type
    uniq_cards = cards.uniq

    card_counts = uniq_cards.map do |c|
      cards.count{|card| card == c}
    end.sort

    return :five_of_a_kind if card_counts == [5]
    return :four_of_a_kind if card_counts == [1, 4]
    return :full_house if card_counts == [2, 3]
    return :three_of_a_kind if card_counts == [1, 1, 3]
    return :two_pair if card_counts == [1, 2, 2]
    return :one_pair if card_counts == [1, 1, 1, 2]
    return :high_card if card_counts == [1, 1, 1, 1, 1]
    binding.pry # wut?
  end
end

class Solution < AbstractSolution
  def parse
    @data.split("\n").map do |l|
      {
        hand: Hand.new(l.split(" ").first.split("")),
        bid: l.split(" ").last.to_i
      }
    end
  end

  def part1
    parse.sort_by{|h| h[:hand]}.each_with_index.sum do |h, i|
      h[:bid] * (i+1)
    end
  end

  def part2
    parse
  end
end
