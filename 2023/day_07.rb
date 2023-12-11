class Hand
  include Comparable

  attr :cards, :orig, :joker

  TYPE_ORDER = [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :full_house,
    :four_of_a_kind,
    :five_of_a_kind
  ]

  def initialize(cards, joker = false)
    @joker = joker
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

  def card_order
    if joker
      ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"]
    else
      ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    end
  end

  def card_strength(card)
    card_order.index(card)
  end

  def type_strength
    TYPE_ORDER.index(hand_type)
  end

  def hand_type
    uniq_cards = cards.uniq

    card_counts = uniq_cards.map do |c|
      cards.count{|card| card == c}
    end.sort

    no_joker_type = if card_counts == [5]
      :five_of_a_kind
    elsif card_counts == [1, 4]
      :four_of_a_kind
    elsif card_counts == [2, 3]
      :full_house
    elsif card_counts == [1, 1, 3]
      :three_of_a_kind
    elsif card_counts == [1, 2, 2]
      :two_pair
    elsif card_counts == [1, 1, 1, 2]
      :one_pair
    elsif card_counts == [1, 1, 1, 1, 1]
      :high_card
    else
      binding.pry # wut?
    end

    return no_joker_type unless joker && cards.include?("J")

    mode_card = cards.max_by{|i| i == "J" ? 0 : cards.count(i)}
    joker_hand = Hand.new(cards.map{|c| c == "J" ? mode_card : c})

    return joker_hand.hand_type if joker_hand.type_strength > TYPE_ORDER.index(no_joker_type)
    no_joker_type
  end
end

class Solution < AbstractSolution
  def parse(joker = false)
    @data.split("\n").map do |l|
      {
        hand: Hand.new(l.split(" ").first.split(""), joker),
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
    parse(true).sort_by{|h| h[:hand]}.each_with_index.sum do |h, i|
      h[:bid] * (i+1)
    end
  end
end
