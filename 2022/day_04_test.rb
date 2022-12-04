class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
    EOF

    def test_part1
        assert_equal 2, Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        assert_equal 4, Solution.new(data: SAMPLE_INPUT).part2
    end
end
