class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
    Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3

    Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
            If true: throw to monkey 2
            If false: throw to monkey 0

    Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
            If true: throw to monkey 1
            If false: throw to monkey 3

    Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
            If true: throw to monkey 0
            If false: throw to monkey 1
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 10605, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 56120, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 99 * 103, Solution.new(data: SAMPLE_INPUT).solve(20, false)
        assert_equal 5204 * 5192, Solution.new(data: SAMPLE_INPUT).solve(1000, false)
        assert_equal 10419 * 10391, Solution.new(data: SAMPLE_INPUT).solve(2000, false)
        assert_equal 15638 * 15593, Solution.new(data: SAMPLE_INPUT).solve(3000, false)
        assert_equal 20858 * 20797, Solution.new(data: SAMPLE_INPUT).solve(4000, false)
        assert_equal 26075 * 26000, Solution.new(data: SAMPLE_INPUT).solve(5000, false)
        assert_equal 31294 * 31204, Solution.new(data: SAMPLE_INPUT).solve(6000, false)
        assert_equal 36508 * 36400, Solution.new(data: SAMPLE_INPUT).solve(7000, false)
        assert_equal 41728 * 41606, Solution.new(data: SAMPLE_INPUT).solve(8000, false)
        assert_equal 46945 * 46807, Solution.new(data: SAMPLE_INPUT).solve(9000, false)
        assert_equal 52166 * 52013, Solution.new(data: SAMPLE_INPUT).solve(10000, false)
        assert_equal 1, Solution.new(data: real_input).part2
    end
end
