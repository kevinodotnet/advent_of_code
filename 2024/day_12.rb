class Solution < AbstractSolution
  DIRS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
  ]

  def peers(p)
    DIRS.map do |dir|
      peer = [p[0] + dir[0], p[1] + dir[1]]
      peer = nil if peer && (peer[0] < 0 || peer[0] >= @data.length)
      peer = nil if peer && (peer[1] < 0 || peer[1] >= @data[0].length)
      peer
    end
  end

  def parse
    @data = @data.split("\n").map{|l| l.split("")}
  end

  def print_data
    puts @data.map{|l| l.join("")}.join("\n")
  end

  def solve
    @crops = {}
    @points = {}

    # create crops, one per cell
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        c = {
          t: cell,
          p: Set.new
        }
        uuid = SecureRandom.uuid
        c[:p] << [y, x]
        @crops[uuid] = c
        @points[[y, x]] = uuid
      end
    end

    # merge cells of same crop, adjacent to each other
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        p = [y, x]
        peers(p).each do |peer|
          next if peer.nil?

          p_uuid = @points[p]
          p_crop = @crops[p_uuid]
          peer_uuid = @points[peer]
          peer_crop = @crops[peer_uuid]

          next if p_uuid == peer_uuid
          next unless p_crop[:t] == peer_crop[:t]

          p_crop[:p] += peer_crop[:p]
          peer_crop[:p].each do |point|
            @points[point] = p_uuid
          end
          @crops.delete(peer_uuid)
        end
      end
    end

    @crops.each do |uuid, c|
      c[:area] = c[:p].length
      c[:fences] = {}
      c[:p].each do |p|
        c[:fences][p] = {}
        DIRS.map do |dir|
          peer = [p[0] + dir[0], p[1] + dir[1]]
          fenced = if @points[peer].nil?
            true
          else
            @points[peer] != uuid
          end
          c[:fences][p][dir] = fenced
        end
      end
      c[:perimeter] = c[:fences].values.map{|f| f.values}.flatten.count(true)
      c[:cost] = c[:area] * c[:perimeter]
    end
  end

  def part1
    solve
    @crops.sum{|u, c| c[:cost]}
  end

  def part2
    solve

    # solve for sides, which are fences in the same crop, adjacent with same `dir`
    # collapse them into `sides` sets, same as for parsing the original crop
    @crops.each do |uuid, c|
      c[:sides] = {}
      DIRS.each do |dir|
        c[:sides][dir] = {}
      end
      c[:fences].each do |p, fs|
        fs.each do |dir, fenced|
          next unless fenced

          # check for peers with fences on the same side, and if they are in a [:sides] set. 
          # If yes, add this fence to the existing side
          # if no, this fence is the first of a new side
          peer_dirs = [
            dir.reverse,
            dir.reverse.map{|c| c * -1}
          ]
          
          matching_sides = peer_dirs.map do |pd|
            peer = [p[0] + pd[0], p[1] + pd[1]]
            
            matching_side_set = c[:sides][dir].select{|u, s| s.include?(peer)}
            matching_side_set.values.first
          end.compact

          merged = false
          if matching_sides.any?
            merged = true
            matching_sides[0] << p
            if matching_sides.count > 1
              matching_sides[0] += matching_sides[1]
              matching_sides[1].clear
            end
          end

          unless merged
            side_id = SecureRandom.uuid
            c[:sides][dir][side_id] = Set.new
            c[:sides][dir][side_id] << p
          end
        end
      end
      c[:side_count] = c[:sides].values.map{|s| s.values}.flatten.select{|s| s.count > 0}.count
      c[:cost2] = c[:area] * c[:side_count]
    end

    @crops.sum{|u, c| c[:cost2]}
  end
end
