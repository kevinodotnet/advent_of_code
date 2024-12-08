class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        190: 10 19
        3267: 81 40 27
        83: 17 5
        156: 15 6
        7290: 6 8 6 15
        161011: 16 10 13
        192: 17 8 14
        21037: 9 7 18 13
        292: 11 6 16 20
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 3749, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 1153997401072, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
