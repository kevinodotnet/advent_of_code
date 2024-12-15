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

  def part1
    @crops = {}
    @points = {}
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

    costs = @crops.map do |uuid, c|
      area = c[:p].length
      perimeter = c[:p].map do |p|
        fences = peers(p).map do |peer|
          if peer.nil?
            1
          else
            peer_uuid = @points[[peer[0],peer[1]]]
            peer_uuid == uuid ? 0 : 1
          end
        end
        fences.sum
      end
      c[:area] = area
      c[:perimeter] = perimeter.sum
      c[:cost] = area * perimeter.sum
    end
    costs.sum
  end

  def part2
  end
end
