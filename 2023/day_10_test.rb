class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        .....
        .S-7.
        .|.|.
        .L-J.
        .....
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        ..F7.
        .FJ|.
        SJ.L7
        |F--J
        LJ...
    EOF

    SAMPLE_INPUT_3 = <<~EOF
        ...........
        .S-------7.
        .|F-----7|.
        .||.....||.
        .||.....||.
        .|L-7.F-J|.
        .|..|.|..|.
        .L--J.L--J.
        ...........
    EOF

    SAMPLE_INPUT_4 = <<~EOF
        .F----7F7F7F7F-7....
        .|F--7||||||||FJ....
        .||.FJ||||||||L7....
        FJL7L7LJLJ||LJ.L-7..
        L--J.L7...LJS7F-7L7.
        ....F-J..F7FJ|L7L7L7
        ....L7.F7||L7|.L7L7|
        .....|FJLJ|FJ|F7|.LJ
        ....FJL-7.||.||||...
        ....L---J.LJ.LJLJ...
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 4, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 8, Solution.new(data: SAMPLE_INPUT_2).part1
        assert_equal 6927, Solution.new(data: real_input).part1
    end

    focus
    def test_part2
        assert_equal 1, Solution.new(data: SAMPLE_INPUT_1).part2
        assert_equal 4, Solution.new(data: SAMPLE_INPUT_3).part2
        assert_equal 8, Solution.new(data: SAMPLE_INPUT_4).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
