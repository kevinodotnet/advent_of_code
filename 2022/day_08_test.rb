class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        30373
        25512
        65332
        33549
        35390
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 21, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 1684, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 8, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 486540, Solution.new(data: real_input).part2
    end
end
