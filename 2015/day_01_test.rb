class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        {
            "(())" => 0,
            "()()" => 0,
            "(((" => 3, 
            "(()(()(" => 3,
            "))(((((" => 3,
            "())" => -1,
            "))(" => -1,
            ")))" => -3,
            ")())())" => -3
        }.each do |k, v|
            assert_equal v, Solution.new(data: k).part1
        end
        assert_equal 138, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
