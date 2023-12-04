class Solution < AbstractSolution
  def parse
    @data = @data.split("\n").map do |l|
      (card_num, d) = l.split(": ")
      card_num = card_num.match(/Card *(\d+)/)[1].to_i
      (winners, numbers) = d.split(" | ").map{|d| d.split(" ").map{|i| i.to_i}}
      winners = Set.new(winners)
      numbers = Set.new(numbers)
      {
        card: card_num,
        count: 1,
        numbers: numbers,
        winners: winners,
        matches: winners.intersection(numbers)
      }
    end
  end

  def part1
    parse.each do |c|
      count = c[:matches].count
      score = if count <= 1
        count
      else
        i = 1
        (count-1).times do
          i = i * 2
        end
        i
      end
      c[:score] = score
    end
    @data.sum{|c| c[:score]}
  end

  def part2
    parse.each_with_index do |c, i|
      matches = c[:matches].count
      c[:count].times do
        matches.times do |t|
          t = t + 1
          @data[i + t][:count] += 1
        end
      end
    end
    @data.sum{|c| c[:count]}
  end
end
