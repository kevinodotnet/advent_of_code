class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 22, Solution.new(data: "125 17").part1(6)
        assert_equal 55312, Solution.new(data: "125 17").part1(25)
        assert_equal 199946, Solution.new(data: real_input).part1(25)
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
