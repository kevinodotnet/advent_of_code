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

  def up_down_left_right(y, x)
    row = @forest[y]
    col = @forest.map{|row| row[x]}

    up = col[0...y].reverse
    down = col[(y+1)..]
    left = row[0...x].reverse
    right = row[(x+1)..]

    [up, down, left, right]
  end

  def part1
    parse
    visible_trees = []
    scan do |y, x, v|
      visible = if y == 0 || x == 0 || y == (@forest.count-1) || x == (@forest.count-1)
        true
      else
        up, down, left, right = up_down_left_right(y, x)

        [up.max, down.max, left.max, right.max].any?{|h| h < v}
      end
      visible_trees << [y, x, visible]
    end
    visible_trees.count{|t| t[2]}
  end

  def part2
    parse
    scenic_scores = []
    scan do |y, x, v|
      scenic_scores << up_down_left_right(y, x).map do |d|
        if d.count == 0
          0
        else
          lower_trees = d.map{|t| t < v}
          if lower_trees.find_index(false).nil?
            d.count
          else
            lower_trees.find_index(false) + 1
          end
        end
      end.inject(&:*)
    end
    scenic_scores.max
  end
end
