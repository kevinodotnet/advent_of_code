class Solution < AbstractSolution
  def parse
    @data = @data.chomp.strip.split("").map(&:to_i)
    @data = @data.each_with_index.map do |d, i|
      type = i % 2 == 0 ? :file : :free
      id = i / 2 if type == :file
      {
        uuid: SecureRandom.uuid,
        length: d,
        type: type,
        id: id,
      }
    end
  end

  def print_data
    @data.each do |b|
      char = b[:type] == :file ? b[:id] : "."
      print "#{char}" * b[:length]
    end
    puts ""
  end

  def move_to_free(free_index, file_index)
    free_block = @data[free_index]
    file_block = @data[file_index]

    new_file_block = { 
      uuid: SecureRandom.uuid,
      length: 0,
      type: :file,
      id: file_block[:id]
    }
    @data.insert(free_index, new_file_block)

    new_free_block = { 
      uuid: SecureRandom.uuid,
      length: 0, 
      type: :free
    }
    @data.insert(file_index + 1, new_free_block)

    while file_block[:length] > 0 && free_block[:length] > 0
      file_block[:length] -= 1
      new_file_block[:length] += 1

      free_block[:length] -= 1
      new_free_block[:length] += 1
    end
  end

  def part1
    file_index = @data.length - 1
    free_index = 0
    while file_index > free_index
      file_index = @data.length - 1
      free_index = 0

      file_index -= 1 while @data[file_index] && @data[file_index][:type] == :free
      free_index += 1 while @data[free_index] && @data[free_index][:type] == :file

      move_to_free(free_index, file_index)

      @data = @data.select{|b| b[:length] > 0}
    end
    pos = 0
    @data = @data.select{|b| b[:length] > 0}
    r = @data.each_with_index.map do |b|
      next if b[:type] == :free
      b[:length].times.map do
        v = b[:id] * pos
        pos += 1
        v
      end
    end
    r.flatten.compact.sum
  end

  def part2
  end
end


