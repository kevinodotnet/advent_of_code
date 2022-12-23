class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        2,2,2
        1,2,2
        3,2,2
        2,1,2
        2,3,2
        2,2,1
        2,2,3
        2,2,4
        2,2,6
        1,2,5
        3,2,5
        2,1,5
        2,3,5
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 64, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 4308, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 58, Solution.new(data: SAMPLE_INPUT).part2
        refute_equal 4062, Solution.new(data: real_input).part2
    end
end
