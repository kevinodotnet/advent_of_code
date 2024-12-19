class SolutionTest < Minitest::Test
    SAMPLE_INPUT_1 = <<~EOF
        p=0,4 v=3,-3
        p=6,3 v=-1,-3
        p=10,3 v=-1,2
        p=2,0 v=2,-1
        p=0,0 v=1,3
        p=3,0 v=-2,-2
        p=7,6 v=-1,-3
        p=3,0 v=-1,-2
        p=9,3 v=2,3
        p=7,3 v=-1,2
        p=2,4 v=2,-3
        p=9,5 v=-3,-3
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 12, Solution.new(data: SAMPLE_INPUT_1).part1(11, 7, 100)
        assert_equal 229421808, Solution.new(data: real_input).part1
    end

    focus
    def test_part2
        assert_equal 456, Solution.new(data: real_input).part2
    end
end
