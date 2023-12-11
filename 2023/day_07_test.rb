class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 6440, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 251106089, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal :four_of_a_kind, Hand.new("AJJJ5".split(""), true).hand_type
        assert_equal 5905, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 249620106, Solution.new(data: real_input).part2
    end
end
