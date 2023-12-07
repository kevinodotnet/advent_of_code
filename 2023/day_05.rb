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
    m[:range] = (m[:src]..(m[:src]+(m[:size]-1)))
    puts "transform_range_via_map: r: #{r} m: #{m}"
    # case: r is contained entirely in [m]; just shift according to :dest
    if m[:range].cover?(r)
      puts "  cover!"
      diff = m[:dest] - m[:src]
      return [
        ((r.first+diff)..(r.last+diff))
      ]
    end

    # case: the two ranges don't touch
    unless m[:range].overlaps?(r)
      puts "  no_shift!"
      return [r]
    end

    # case: partial overlap
    # split (r) into sub-ranges that align to above cases, then go recursive
    ranges = []
    r1 = r.first
    r2 = nil
    loop do
      r2 = if m[:range].include?(r1)
        [m[:range].last, r.last].min
      else
        # binding.pry if [m[:range].first-1, r.last].select{|o| o > r1}.empty?
        [m[:range].first-1, r.last].select{|o| o > r1 || o == r.last}.min
      end
      ranges << (r1..r2)
      #binding.pry
      break if r2 == r.last
      if r1 == r2
        r1 += 1
      else
        r1 = r2 + 1
      end
      r2 = nil
    end

    result = ranges.map{|r| m[:range].cover?(r) ? transform_range_via_map(r, m) : r}.flatten

    result
  end

  def part2
    parse

    layers = @mappings.values.map do |m|
      m.values.first.to_a.map do |r|
        r[:size] = r[:range]
      end
      m.values.first.to_a.sort{|a, b| a[:src] <=> b[:src]}
    end

    rr = @seeds.each_slice(2).map do |num, t|
      ranges = [
        (num..(num+t))
      ]

      layers.map do |maps|
        maps.map do |m|
          ranges = ranges.map do |r|
            transform_range_via_map(r, m)
          end.flatten
          # binding.pry if 0 == ranges.sort{|a, b| a.first <=> b.first}.first.first
        end
      end

      puts ranges.sort{|a, b| a.first <=> b.first}
      binding.pry if ranges.sort{|a, b| a.first <=> b.first}.first.first == 0
      ranges.sort{|a, b| a.first <=> b.first}.first.first
    end.compact

    puts rr
    rr.min
  end
end
