class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 95437, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 1543140, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 24933642, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 1117448, Solution.new(data: real_input).part2
    end
end
