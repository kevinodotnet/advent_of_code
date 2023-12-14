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

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 4, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 8, Solution.new(data: SAMPLE_INPUT_2).part1
        # assert_equal 123, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
