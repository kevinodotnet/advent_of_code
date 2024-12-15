class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        AAAA
        BBCD
        BBCC
        EEEC
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        RRRRIICCFF
        RRRRIICCCF
        VVRRRCCFFF
        VVRCCCJFFF
        VVVVCJJCFE
        VVIVCCJJEE
        VVIIICJJEE
        MIIIIIJJEE
        MIIISIJEEE
        MMMISSJEEE
    EOF

    SAMPLE_INPUT_3 = <<~EOF
        OOOOO
        OXOXO
        OOOOO
        OXOXO
        OOOOO
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 140, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 772, Solution.new(data: SAMPLE_INPUT_3).part1
        assert_equal 1930, Solution.new(data: SAMPLE_INPUT_2).part1
        assert_equal 1461752, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
