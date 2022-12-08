class Solution < AbstractSolution
  def parse
    @forest = @data.split("\n").map{|i| i.split("").map{|i| i.to_i}}
  end

  def scan
    @forest.each_with_index do |row, y|
      row.each_with_index do |v, x|
        yield(y, x, v)
      end
    end
  end

  def part1
    parse
    visible_trees = []
    scan do |y, x, v|
      visible = if y == 0 || x == 0 || y == (@forest.count-1) || x == (@forest.count-1)
        true
      else
        row = @forest[y]
        col = @forest.map{|row| row[x]}

        up = col[0...y].max
        down = col[(y+1)..].max
        left = row[0...x].max
        right = row[(x+1)..].max

        [up, down, left, right].any?{|h| h < v}
      end
      visible_trees << [y, x, visible]
    end
    visible_trees.count{|t| t[2]}
  end

  def part2
    # parse
  end
end
