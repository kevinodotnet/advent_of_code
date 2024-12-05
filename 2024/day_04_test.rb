class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 18, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 2557, Solution.new(data: real_input).part1
    end

    def test_part2_001
        data = <<~EOF
            .....MS...
            ......A...
            ......MS..
        EOF
        assert_equal 0, Solution.new(data:).part2
    end

    def test_part2_002
        data = <<~EOF
            ......S...
            .....MAS..
            ......M...
        EOF
        assert_equal 0, Solution.new(data:).part2
    end

    def test_part2_003
        data = <<~EOF
            .....M.S..
            ......A...
            .....M.S..
        EOF
        assert_equal 1, Solution.new(data:).part2
    end

    def test_part2_004
        data = <<~EOF
            .....M.S..
            ......A...
            .....M.S..
            ......A...
            .....M.S..
        EOF
        assert_equal 2, Solution.new(data:).part2
    end

    def test_part2_004
        data = <<~EOF
            .M.S......
            ..A..MSMS.
            .M.S.MAA..
            ..A.ASMSM.
            .M.S.M....
            ..........
            S.S.S.S.S.
            .A.A.A.A..
            M.M.M.M.M.
            ..........
        EOF
        assert_equal 9, Solution.new(data:).part2
    end

    def test_part2
        assert_equal 9, Solution.new(data: SAMPLE_INPUT_1).part2
        assert_equal 1854, Solution.new(data: real_input).part2
    end
end
