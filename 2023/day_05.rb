class Solution < AbstractSolution
  def parse
    @data = @data.split("\n\n")
    @seeds = @data.shift.scan(/\d+/).map{|d| d.to_i}.sort
    @mappings = {}
    @data.each do |d|
      d = d.split("\n")
      m, src, dest = d.shift.match(/^(.*)-to-(.*) map:/).to_a
      src = src.to_sym
      dest = dest.to_sym
      maps = d.map do |m|
        m = m.scan(/\d+/).map{|d| d.to_i}
        {
          src: m[1],
          dest: m[0],
          range: m[2]
        }
      end
      @mappings[src] ||= {}
      @mappings[src][dest] ||= Set.new
      @mappings[src][dest] += maps
    end
  end

  def next_step(type, num)
    raise StandardError, 'oh no' if @mappings[type].keys.count > 1

    next_type = @mappings[type].keys.first
    range = @mappings[type][next_type].detect do |r|
      ((r[:src])..(r[:src]+r[:range])).include?(num)
    end
    dest_num = if range
      num - range[:src] + range[:dest]
    else
      num
    end
    return dest_num if next_type == :location
    next_step(next_type, dest_num)
  end

  def part1
    parse
    @seeds.map{|s| next_step(:seed, s)}.min
  end

  def part2
    parse
  end
end
