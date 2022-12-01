class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        a
        b
        c
    EOF

    def test_part1
        assert_equal 123, Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
    end
end
