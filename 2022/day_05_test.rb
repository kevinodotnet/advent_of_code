class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<EOF
    [D]
[N] [C]
[Z] [M] [P]
1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
EOF

    def test_part1
        assert_equal "CMZ", Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
    end
end
