class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 1, Solution.new(data: "^").part1
        assert_equal 1, Solution.new(data: "v").part1
        assert_equal 2, Solution.new(data: "<").part1
        assert_equal 2, Solution.new(data: ">").part1
        assert_equal 4, Solution.new(data: "^>v<").part1
        assert_equal 2, Solution.new(data: "^v^v^v^v^v").part1
        assert_equal 2081, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 2081, Solution.new(data: real_input).part2
    end
end
