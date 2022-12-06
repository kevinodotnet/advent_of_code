class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        mjqjpqmgbljsphdztnvjfqwrcgsmlb
    EOF

    OTHERS_INPUTS = {
        "bvwbjplbgvbhsrlpgdmjqwftvncz" => 5,
        "nppdvjthqldpwncqszvftbrmjlhg" => 6,
        "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" => 10,
        "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" => 11
    }

    def test_part1
        OTHERS_INPUTS.each do |k,v|
            assert_equal v, Solution.new(data: k).part1
        end
        assert_equal 7, Solution.new(data: SAMPLE_INPUT).part1
    end

    def test_part2
        # assert_equal 456, Solution.new(data: SAMPLE_INPUT).part2
    end
end
