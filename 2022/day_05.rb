class Solution < AbstractSolution
#     [D]
# [N] [C]
# [Z] [M] [P]
# 1   2   3

# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2

  attr_reader :stacks, :moves

  def parse
    state, moves = @data.split("\n\n")
    state = state.split("\n").map do |l|
      l.split("").each_slice(4)
    end
    stack_nums = state.pop.map{|c| c.join("").to_i}
    @stacks = {}
    state.reverse.each do |l|
      l.each_with_index do |v, i|
        @stacks[stack_nums[i]] ||= []
        @stacks[stack_nums[i]] << v[1] unless v[1] == " "
      end
    end
    @moves = moves.split("\n").map do |m|
      count, move_from, move_to = m.scan(/\d+/)
      {
        move_from: move_from.to_i,
        move_to: move_to.to_i,
        count: count.to_i,
      }
    end
  end

  def apply_moves(group_move: )
    @moves.each do |m|
      moving = @stacks[m[:move_from]].pop(m[:count])
      moving = moving.reverse unless group_move
      @stacks[m[:move_to]].push(*moving)
    end
  end

  def part1
    parse
    apply_moves(group_move: false)
    @stacks.map{|k,v| v.last}.join("")
  end

  def part2
    parse
    apply_moves(group_move: true)
    @stacks.map{|k,v| v.last}.join("")
  end
end
