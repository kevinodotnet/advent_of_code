class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 58, Solution.new(data: "2x3x4").part1
        assert_equal 43, Solution.new(data: "1x1x10").part1
        assert_equal 1598415, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 34, Solution.new(data: "2x3x4").part2
        assert_equal 14, Solution.new(data: "1x1x10").part2
        assert_equal 3812909, Solution.new(data: real_input).part2
    end
end
