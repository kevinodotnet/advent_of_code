class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 2, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 6, Solution.new(data: SAMPLE_INPUT_2).part1
        assert_equal 14893, Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
