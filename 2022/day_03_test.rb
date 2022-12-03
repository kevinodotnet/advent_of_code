class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
    EOF

    def test_part1
        assert_equal 157, Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        assert_equal 70, Solution.new(data: SAMPLE_INPUT).part2
    end
end
