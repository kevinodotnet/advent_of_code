class Solution < AbstractSolution
  def parse
    @ordering, @updates = @data.split("\n\n").map { |x| x.split("\n") }
    @ordering = @ordering.map { |x| x.split("|").map(&:to_i) }
    @updates = @updates.map { |x| x.split(",").map(&:to_i) }
  end

  def in_order
    @updates.select do |update|
      @ordering.map do |pair|
        next unless update.include?(pair[0])
        next unless update.include?(pair[1])
        update.index(pair[0]) < update.index(pair[1])
      end.compact.all?(true)
    end
  end

  def out_of_order
    @updates.select do |update|
      @ordering.map do |pair|
        next unless update.include?(pair[0])
        next unless update.include?(pair[1])
        update.index(pair[0]) < update.index(pair[1])
      end.compact.any?(false)
    end
  end

  def part1
    in_order.map do |update|
      update[update.length / 2]
    end.sum
  end

  def part2
    out_of_order.map do |update|
      ordered = []
      update.each do |x|
        i = 0
        @ordering.select do |pair|
          next unless pair.include?(x)
          next unless ordered.include?(pair[0]) || ordered.include?(pair[1])
          other = pair.detect{|p| p != x}
          other_i = ordered.index(other)
          if other == pair[1]
            # x is before other
            if i >= other_i
              i = other_i
            end
          else
            # x is after other
            if i <= other_i
              i = other_i + 1
            end
          end
        end
        ordered.insert(i, x)
      end
      ordered[ordered.length / 2]
    end.sum
  end
end
