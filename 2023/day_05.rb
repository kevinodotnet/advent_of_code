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

  #
  # part 1
  #

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

  #
  # PART 2
  #

  def transform_range_via_map(r, m, expect_no_chunking: false)
    # r: a range of seeds that need to be mapped to one or more resulting ranges
    #    example: 105..1000, inclusive!
    #
    # m: a single mapping definition, per instructions
    #    example: {:src=>995, :dest=>2000, :size=>10}
    #             this causes 995..1004 inclusive to be mapped to 2000..2004

    # create an inclusive Range object for the :src of the map, to compare with r
    m[:range] = (m[:src]..(m[:src]+(m[:size]-1)))

    #
    # if the seed range does not intersect at all with the mapping, it passes
    # through unmodified
    #
    unless m[:range].overlaps?(r)
      return {
        skipped: [r],
        shifted: []
      }
    end

    #
    # if the entirety of R is covered by the map, simply shift R to the :dest
    #
    if m[:range].cover?(r)
      diff = m[:dest] - m[:src]
      return {
        skipped: [],
        shifted: [
          ((r.first+diff)..(r.last+diff))
        ]
      }
    end

    binding.pry if expect_no_chunking # this would be a surprise at this point

    #
    # the range and the mapping intersect somehow, but a portion of the range
    # is not covered by the map, so multiple ranges will be returned, corresponding
    # to the parts that pass through unmodified, or are shifted
    #

    #
    # start at the beginning of the seed range and "chunk" resulting ranges depending
    # on if the chunk intersects with the mapping or not, until the seed range is
    # exhausted
    #

    ranges = []
    r1 = r.first
    r2 = nil
    loop do
      r2 = if m[:range].include?(r1)
        # the chunk starts (r1) within the mapping
        # set r2 to be the end of the seed range, or the end of the map, which ever comes first
        [
          m[:range].last,
          r.last
        ].min
      else
        # the chunk starts (r1) outside of the mapping (before or after, not sure)
        # set r2 to be one before the start of the mapping, or the end of the seed range, which ever comes first
        # ... but only for values larger than the current r1 chunk start

        [
          m[:range].first-1,
          r.last
        ].select do |o|
          o >= r1
        end.min
      end
      ranges << (r1..r2) # produce a chunk

      break if r2 == r.last # end of chunk processing

      r1 = r2 + 1 # step to after the chunk, and go again
      r2 = nil
    end

    # the original single range [r] has been chunked into multiple ranges which should either
    # intersect perfectly with the mapping, or not intersect at all. Go recursive to use the
    # "pass-thru" or "shift" use cases as needed
    result = {
      skipped: ranges.reject{|r| m[:range].overlaps?(r)},
      shifted: ranges
        .select{|r| m[:range].overlaps?(r)}
        .map{|r| transform_range_via_map(r, m, expect_no_chunking: true)[:shifted]}
        .flatten
    }

    result
  end

  def part2
    parse

    layers = @mappings.values.map do |m|
      m.values.first.to_a.map do |r|
        r[:size] = r[:range]
        r.delete(:range)
      end
      m.values.first.to_a.sort{|a, b| a[:src] <=> b[:src]}
    end

    # layers is in order, starting with seed-to-soil down to humidity-to-location
    # [{:src=>50, :dest=>52, :size=>48}, {:src=>98, :dest=>50, :size=>2}],
    # [{:src=>0,  :dest=>39, :size=>15}, {:src=>15, :dest=>0,  :size=>37}, {:src=>52, :dest=>37, :size=>2}],
    # [{:src=>0,  :dest=>42, :size=>7 }, {:src=>7,  :dest=>57, :size=>4},  {:src=>11, :dest=>0,  :size=>42}, {:src=>53, :dest=>49, :size=>8}],
    # [{:src=>18, :dest=>88, :size=>7 }, {:src=>25, :dest=>18, :size=>70}],
    # [{:src=>45, :dest=>81, :size=>19}, {:src=>64, :dest=>68, :size=>13}, {:src=>77, :dest=>45, :size=>23}],
    # [{:src=>0,  :dest=>1,  :size=>69}, {:src=>69, :dest=>0,  :size=>1}],
    # [{:src=>56, :dest=>60, :size=>37}, {:src=>93, :dest=>56, :size=>4}]

    seeds_to_locations = @seeds.each_slice(2).map do |num, t|
      # seeds line is "starting_seed_number" and then "t" seeds
      # so num=10 and t=2 means the seed range is 10..11 inclusive
      ranges = [
        (num..(num+t-1))
      ]

      puts ""
      puts ""
      puts ""
      puts "SEED! #{num} ranges: #{ranges}"
      puts ""
      puts ""
      puts ""
      puts ""

      # for each layer, transform [rangers] by applying the maps included in this layer, per #transform_range_via_map
      transformed = layers.map do |maps|
        puts "#"
        puts "LAYER!"
        puts "#"
        shifted = []

        maps.each do |m|
          puts ""
          puts "  map:#{m}"
          puts "  ranges.count: #{ranges.count}"
          puts "  ranges: #{ranges}"
          puts "  shifted.count: #{shifted.count}"
          ranges = ranges.map do |r|
            puts ""
            puts "  r: #{r}"
            result = transform_range_via_map(r, m)
            puts "  r.skipped: #{result[:skipped]}"
            puts "  r.shifted: #{result[:shifted]}"
            shifted += result[:shifted]
            result[:skipped]
          end.flatten
        end

        ranges = (ranges + shifted).flatten
      end

      # having transformed from the starting singular "seed range", find the minimum resulting location
      # after all translations
      transformed.last.sort{|a, b| a.first <=> b.first}.first.first
    end

    # pick the smallest of all of the seeds_to_locations
    seeds_to_locations.min
  end
end
