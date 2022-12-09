class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 13, Solution.new(data: SAMPLE_INPUT).part1
        # assert_equal 123, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
