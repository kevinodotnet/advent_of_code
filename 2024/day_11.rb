class Solution < AbstractSolution
  def parse
    @data = @data.scan(/\d+/).map(&:to_i)
  end

  def blink
    i = 0
    while i < @data.length
      v = @data[i]
      # If the stone is engraved with the number 0, it is replaced by a stone engraved with the number 1.
      if v == 0
        @data[i] = 1
        i += 1
        next
      end

      # If the stone is engraved with a number that has an even number of digits, it is replaced by two stones. 
      # The left half of the digits are engraved on the new left stone, and the right half of the digits are engraved on the new right stone. 
      # (The new numbers don't keep extra leading zeroes: 1000 would become stones 10 and 0.)
      v_as_s = v.to_s
      if v_as_s.length.even?
        left = v_as_s[0...(v_as_s.length / 2)].to_i
        right = v_as_s[(v_as_s.length / 2)..-1].to_i

        @data[i] = left
        @data.insert(i + 1, right)
        i += 2 # skip added stone
        next
      end

      # If none of the other rules apply, the stone is replaced by a new stone; the old stone's number multiplied by 2024 is engraved on the new stone.
      @data[i] = v * 2024
      i += 1
    end
  end

  def part1(blinks)
    blinks.times { blink }
    @data.count
  end

  def part2
  end
end
