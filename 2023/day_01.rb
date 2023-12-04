class Solution < AbstractSolution
  SYMBOLS = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def line_to_number(line, symbols)
    i = 0
    digits = []
    while i < line.length
      substr = line[i..line.length]
      i += 1
      if substr.match?(/^\d/)
        digits << substr.first
        next
      end
      if symbols
        SYMBOLS.each do |k, v|
          if substr.starts_with?(k.to_s)
            digits << v
            break
          end
        end
      end
    end
    [
      digits.first,
      digits.last
    ].join("").to_i
  end

  def parse(symbols)
    @data.split("\n").map do |l|
      line_to_number(l, symbols)
    end
  end

  def part1
    parse(false).sum
  end

  def part2
    parse(true).sum
  end
end
