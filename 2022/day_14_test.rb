class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        498,4 -> 498,6 -> 496,6
        503,4 -> 502,4 -> 502,9 -> 494,9
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 24, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 994, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 93, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 26283, Solution.new(data: real_input).part2
    end
end
