class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        ###############
        #.......#....E#
        #S#.###########
        #S............#
        ###############
    EOF

    SAMPLE_INPUT_1 = <<~EOF
        ###############
        #.......#....E#
        #.#.###.#.###.#
        #.....#.#...#.#
        #.###.#####.#.#
        #.#.#.......#.#
        #.#.#####.###.#
        #...........#.#
        ###.#.#####.#.#
        #...#.....#.#.#
        #.#.#.###.#.#.#
        #.....#...#.#.#
        #.###.#.#.#.#.#
        #S..#.....#...#
        ###############
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        #################
        #...#...#...#..E#
        #.#.#.#.#.#.#.#.#
        #.#.#.#...#...#.#
        #.#.#.#.###.#.#.#
        #...#.#.#.....#.#
        #.#.#.#.#.#####.#
        #.#...#.#.#.....#
        #.#.#####.#.###.#
        #.#.#.......#...#
        #.#.###.#####.###
        #.#.#...#.....#.#
        #.#.#.#####.###.#
        #.#.#.........#.#
        #.#.#.#########.#
        #S#.............#
        #################
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1a
        assert_equal 7036, Solution.new(data: SAMPLE_INPUT_1).part1
    end

    def test_part1b
        assert_equal 11048, Solution.new(data: SAMPLE_INPUT_2).part1
    end

    focus
    def test_part1
        assert_equal 65436, Solution.new(data: real_input).part1
    end

    def test_part2a
        assert_equal 45, Solution.new(data: SAMPLE_INPUT_1).part2
    end

    def test_part2b
        assert_equal 45, Solution.new(data: SAMPLE_INPUT_1).part2
    end
end
