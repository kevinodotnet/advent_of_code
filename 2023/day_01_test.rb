class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
    EOF

    SAMPLE_INPUT_2 = <<~EOF
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 142, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 54239, Solution.new(data: real_input).part1
    end

    {
        "eighttwo": 82,
        "two1nine": 29,
        "eightwothree": 83,
        "abcone2threexyz": 13,
        "xtwone3four": 24,
        "4nineeightseven2": 42,
        "zoneight234": 14,
        "7pqrstsixteen": 76,
    }.each do |k, v|
        define_method("test_#{k}_#{v}") do
            assert_equal v, Solution.new(data: k.to_s).line_to_number(k.to_s, true)
        end
    end

    def test_part2
        assert_equal 281, Solution.new(data: SAMPLE_INPUT_2).part2
        assert_equal 456, Solution.new(data: real_input).part2
    end
end
