class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 114, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 1953784198, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
