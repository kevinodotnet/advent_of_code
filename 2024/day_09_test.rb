class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        2333133121414131402
    EOF

    TEST = <<~EOF
        00...111...2...333.44.5555.6666.777.888899
        009..111...2...333.44.5555.6666.777.88889.
        0099.111...2...333.44.5555.6666.777.8888..
        00998111...2...333.44.5555.6666.777.888...
        009981118..2...333.44.5555.6666.777.88....
        0099811188.2...333.44.5555.6666.777.8.....
        009981118882...333.44.5555.6666.777.......
        0099811188827..333.44.5555.6666.77........
        00998111888277.333.44.5555.6666.7.........
        009981118882777333.44.5555.6666...........
        009981118882777333644.5555.666............
        00998111888277733364465555.66.............
        0099811188827773336446555566..............
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 1928, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 6211348208140, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 2858, Solution.new(data: SAMPLE_INPUT_1).part2
        assert_equal 6239783302560, Solution.new(data: real_input).part2
    end
end
