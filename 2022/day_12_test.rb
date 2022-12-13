class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        Sabqponm
        abcryxxl
        accszExk
        acctuvwj
        abdefghi
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 31, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 423, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
