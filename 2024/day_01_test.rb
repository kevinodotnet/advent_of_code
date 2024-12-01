class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        3   4
        4   3
        2   5
        1   3
        3   9
        3   3
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 11, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 1388114, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
