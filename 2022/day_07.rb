class Solution < AbstractSolution
  def fs_entry(type: , name: nil, size: nil, parent: nil)
    {
      type: type,
      size: size.to_i,
      name: name,
      contents: {},
      parent: parent
    }
  end

  def set_sizes(dir)
    dir[:contents].each do |n, e|
      set_sizes(e) if e[:type] == :dir
    end
    dir[:size] = dir[:contents].map{|n,e| e[:size].to_i}.sum
  end

  def parse
    @fs = fs_entry(type: :dir)
    @cur_dir = @fs

    @data.split(/^\$ /).each do |prg|
      next if prg == ""
      cmd_args, *output = prg.split("\n")
      cmd, arg = cmd_args.split(" ")
      case cmd
      when "cd"
        if arg == "/"
          @cur_dir = @fs
        elsif arg == ".."
          @cur_dir = @cur_dir[:parent]
        else
          @cur_dir = @cur_dir[:contents][arg]
        end
      when "ls"
        output.each do |l|
          if m = l.match(/^dir (?<name>.*)/)
            @cur_dir[:contents][m[:name]] ||= fs_entry(parent: @cur_dir, type: :dir, name: m[:name])
          elsif m = l.match(/^(?<size>\d+) (?<name>.*)/)
            @cur_dir[:contents][m[:name]] ||= fs_entry(parent: @cur_dir, type: :file, name: m[:name], size: m[:size])
          end
        end
      end
    end

    set_sizes(@fs)
  end

  def scan(dir, &block)
    dir[:contents].each do |n, e|
      scan(e, &block)
    end
    block.call(dir)
  end

  def part1
    parse
    dirs = []
    scan(@fs) do |e|
      dirs << e if e[:type] == :dir
    end
    dirs.map{|e| e[:size]}.select{|s| s <= 100000}.sum
  end

  def part2
    # parse
  end
end
