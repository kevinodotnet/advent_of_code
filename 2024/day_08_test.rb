class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        ............
        ........0...
        .....0......
        .......0....
        ....0.......
        ......A.....
        ............
        ............
        ........A...
        .........A..
        ............
        ............
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 14, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 265, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 34, Solution.new(data: SAMPLE_INPUT_1).part2
        assert_equal 962, Solution.new(data: real_input).part2
    end
end
