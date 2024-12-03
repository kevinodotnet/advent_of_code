class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 161, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 170778545, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 48, Solution.new(data: SAMPLE_INPUT_2).part2
        assert_equal 82868252, Solution.new(data: real_input).part2
    end
end
