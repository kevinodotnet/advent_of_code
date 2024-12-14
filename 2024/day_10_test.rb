class SolutionTest < Minitest::Test
    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        input = <<~EOF
            0123
            1234
            8765
            9876
        EOF
        assert_equal 1, Solution.new(data: input).part1

        input = <<~EOF
            89010123
            78121874
            87430965
            96549874
            45678903
            32019012
            01329801
            10456732        
        EOF
        assert_equal 36, Solution.new(data: input).part1
        assert_equal 123, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
