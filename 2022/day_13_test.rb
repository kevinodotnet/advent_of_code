class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        [1,1,3,1,1]
        [1,1,5,1,1]

        [[1],[2,3,4]]
        [[1],4]

        [9]
        [[8,7,6]]

        [[4,4],4,4]
        [[4,4],4,4,4]

        [7,7,7,7]
        [7,7,7]

        []
        [3]

        [[[]]]
        [[]]

        [1,[2,[3,[4,[5,6,7]]]],8,9]
        [1,[2,[3,[4,[5,6,0]]]],8,9]
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 13, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 5529, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 140, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 456, Solution.new(data: real_input).part2
    end
end
