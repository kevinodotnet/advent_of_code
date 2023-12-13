class Solution < AbstractSolution
  def parse
    @data = @data.split("\n")
    @steps = @data.shift.split("").map{|s| s}
    @data.shift
    @nodes = {}
    @data.each do |l|
      _, from, left, right = l.match(/^(.*) = \((.*), (.*)\)/).to_a
      @nodes[from] = {
        "L" => left,
        "R" => right
      }
    end
  end

  def part1
    parse
    loc = "AAA"
    count = 0
    loop do
      @steps.each do |s|
        count += 1
        loc = @nodes[loc][s]
        return count if loc == "ZZZ"
      end
    end
    binding.pry # bad
  end

  def part2
    parse
    starting_nodes = @nodes.keys.select{|n| n.ends_with?("A") }.map do |loc|
      {
        loc => {
          at: loc,
          looped: false,
          finishes: []
        }
      }
    end.reduce({}, :merge)

    ending_nodes = @nodes.keys.select{|n| n.ends_with?("Z") }
    locs = starting_nodes.dup

    count = 0
    step = @steps[count % @steps.count]

    while !locs.all?{|loc, v| v[:looped]} do
      locs.each do |loc, v|
        v[:at] = @nodes[v[:at]][step]
      end

      count += 1
      step = @steps[count % @steps.count]

      locs.select{|loc, v| ending_nodes.include?(v[:at])}.each do |loc, v|
        # remember that for starting location :loc
        # ... currently arrived at the end v[:at]
        # ... with NEXT step :step
        # ... it took :count steps to get here
        finish = {
          at: v[:at],
          next_step: step,
          count: count
        }
        if v[:finishes].any?{|f| f[:at] == finish[:at] && f[:next_step] == step}
          # we've been here before, taking the same next step, so we'll loop if we do
          v[:looped] = true
        else
          v[:finishes] << finish
        end
      end
    end

    # number of steps to simultaneously hit an end point for all starting positions
    # is the lowest common multiple of all of the step counts that initiated a loop
    # ... turns out it wasn't necessary to remember multiple FINISH points, but that
    # could have been a factor.
    locs.map{|loc, v| v[:finishes].last[:count] }.reduce(1) { |acc, n| acc.lcm(n) }
  end
end
