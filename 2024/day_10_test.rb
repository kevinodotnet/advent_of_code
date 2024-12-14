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
        assert_equal 744, Solution.new(data: real_input).part1
    end

    def test_part2
        input = <<~EOF
            ...0...
            ...1...
            ...2...
            6543456
            7.....7
            8.....8
            9.....9
        EOF
        assert_equal 2, Solution.new(data: input).part2

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
        assert_equal 81, Solution.new(data: input).part2
        assert_equal 1651, Solution.new(data: real_input).part2
    end
end
