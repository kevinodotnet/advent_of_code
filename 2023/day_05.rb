class Solution < AbstractSolution
  def parse
    @data = @data.split("\n\n")
    @seeds = @data.shift.scan(/\d+/).map{|d| d.to_i}
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

  def transform_range_via_map(r, m)
    # case: r is contained entirely in [m]; just shift according to :dest
    if m[:range].cover?(r)
      diff = m[:dest] - m[:src]
      return [
        ((r.first+diff)..(r.last+diff))
      ]
    end

    # case: the two ranges don't touch
    unless m[:range].overlaps?(r)
      return [r]
    end

    # case: partial overlap
    # split (r) into sub-ranges that align to above cases, then go recursive
    ranges = []
    r1 = r.first
    r2 = nil
    loop do
      r2 = [
        m[:range].first,
        m[:range].first + m[:size],
        r.last,
      ].select{|r| r > r1}.min
      break if r2.nil?
      range_end = r2 == r.last ? r2 : (r2-1)
      ranges << (r1..range_end)
      r1 = r2
      r2 = nil
    end

    ranges.map{|r| m[:range].cover?(r) ? transform_range_via_map(r, m) : r}.flatten
  end

  def part2
    parse

    layers = @mappings.values.map do |m|
      m.values.first.to_a.map do |r|
        r[:size] = r[:range]
        r[:range] = (r[:src]..(r[:src]+r[:size]))
      end
      m.values.first.to_a.sort{|a, b| a[:src] <=> b[:src]}
    end

    @seeds.each_slice(2).map do |num, t|
      puts "num: #{num}"
      ranges = [
        (num..(num+t))
      ]

      layers.map do |maps|
        maps.map do |m|
          ranges = ranges.map do |r|
            transform_range_via_map(r, m)
          end.flatten
        end
      end

      ranges.sort{|a, b| a.first <=> b.first}.first.first
    end.min
  end
end
