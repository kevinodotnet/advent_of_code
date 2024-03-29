class Solution < AbstractSolution
  def parse
    @data
    vals = []
    vals << ('a'..'z').to_a
    vals << ('A'..'Z').to_a
    vals = vals.flatten
    @board = @data.split("\n").map{|r| r.split("")}
    @start_at = []
    @end_at = []
    @board = @board.map.with_index do |r, y|
      r.map.with_index do |c, x|
        if c == 'S'
          c = 'a'
          @start_at = [y, x]
        elsif c == 'E'
          @end_at = [y, x]
          c = 'z'
        end
        {
          y: y,
          x: x,
          h: vals.find_index(c),
          cost: nil
        }
      end
    end
  end

  def peers(l)
    cells = []
    cells << @board[l[:y]-1][l[:x]] if l[:y]-1 >= 0
    cells << @board[l[:y]+1][l[:x]] if l[:y] < (@board.count-1)
    cells << @board[l[:y]][l[:x]-1] if l[:x]-1 >= 0
    cells << @board[l[:y]][l[:x]+1] if l[:x] < (@board[0].count-1)
    cells.compact.select do |c|
      l[:h] < c[:h] || l[:h] - c[:h] <= 1
    end
  end

  def solve
    parse
    end_loc = @board[@end_at[0]][@end_at[1]]
    end_loc[:cost] = 0

    locations = [end_loc]

    while l = locations.shift
      locations += peers(l).select do |c|
        was_nil = c[:cost].nil?
        c[:cost] ||= l[:cost] + 1
        c[:cost] = l[:cost] + 1 if c[:cost] > l[:cost]
        was_nil
      end
    end
  end

  def part1
    solve
    @board[@start_at[0]][@start_at[1]][:cost]
  end

  def part2
    solve
    @board.flatten.select{|c| c[:h] == 0 && c[:cost]}.sort_by{|c| c[:cost]}.first[:cost]
  end
end
