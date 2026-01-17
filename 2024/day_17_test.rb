class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        Register A: 729
        Register B: 0
        Register C: 0

        Program: 0,1,5,4,3,0
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal "4,6,3,5,6,3,5,2,1,0", Solution.new(data: SAMPLE_INPUT_1).part1
        assert_equal "3,7,1,7,2,1,0,6,3", Solution.new(data: real_input).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT_1).part2
        # assert_equal 456, Solution.new(data: real_input).part2
    end
end
