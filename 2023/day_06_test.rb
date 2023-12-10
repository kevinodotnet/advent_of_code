class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        Time:      7  15   30
        Distance:  9  40  200
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 288, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 6209190, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 71503, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 28545089, Solution.new(data: real_input).part2
    end
end
