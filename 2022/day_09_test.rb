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

    SAMPLE_INPUT_2 = <<~EOF
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 13, Solution.new(data: SAMPLE_INPUT).part1
        refute_equal 6235, Solution.new(data: real_input).part1
        assert_equal 6236, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 36, Solution.new(data: SAMPLE_INPUT_2).part2
        assert_equal 2449, Solution.new(data: real_input).part2
    end
end
