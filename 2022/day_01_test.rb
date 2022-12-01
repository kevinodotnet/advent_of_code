class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
    EOF

    def test_part1
        assert_equal 24000, Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        # assert_equal "FOO", Solution.new(data: SAMPLE_INPUT).part2
    end
end
