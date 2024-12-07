class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        ....#.....
        .........#
        ..........
        ..#.......
        .......#..
        ..........
        .#..^.....
        ........#.
        #.........
        ......#...
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 41, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 5177, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 6, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
