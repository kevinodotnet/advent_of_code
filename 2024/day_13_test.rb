class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        Button A: X+94, Y+34
        Button B: X+22, Y+67
        Prize: X=8400, Y=5400

        Button A: X+26, Y+66
        Button B: X+67, Y+21
        Prize: X=12748, Y=12176

        Button A: X+17, Y+86
        Button B: X+84, Y+37
        Prize: X=7870, Y=6450

        Button A: X+69, Y+23
        Button B: X+27, Y+71
        Prize: X=18641, Y=10279
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 480, Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal 31589, Solution.new(data: real_input).part1
    end

    def test_part2
        assert_equal 98080815200063, Solution.new(data: real_input).part2
    end
end
