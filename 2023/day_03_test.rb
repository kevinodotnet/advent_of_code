class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse
        expected = {y: 0, x: 0, n: 467}
        assert_equal expected, s.number_at(0, 2)
        assert_equal 4361, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 123, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
