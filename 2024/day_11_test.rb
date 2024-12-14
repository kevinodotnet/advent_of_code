class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 22, Solution.new(data: "125 17").solve(6)
        assert_equal 55312, Solution.new(data: "125 17").solve(25)
        assert_equal 199946, Solution.new(data: real_input).solve(25)
    end

    focus
    def test_part2
        assert_equal 237994815702032, Solution.new(data: real_input).solve(75)
    end
end
