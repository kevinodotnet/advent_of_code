class SolutionTest < Minitest::Test
    SAMPLE_INPUT = <<~EOF
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
    EOF

    def real_input
        day = __FILE__.match(/\d+/)
        File.read("day_#{day}.input")
    end

    def test_part1
        assert_equal 35, Solution.new(data: SAMPLE_INPUT).part1
        assert_equal 650599855, Solution.new(data: real_input).part1
    end

    def test_transform_range_via_map
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse

        expected = [(81..95)]
        assert_equal expected, s.transform_range_via_map(79..93, {:src=>50, :dest=>52, :range=>50..98, :size=>48})

        expected = [(10..20)]
        assert_equal expected, s.transform_range_via_map(10..20, {:src=>50, :dest=>52, :range=>50..98, :size=>48})

        expected = [
            (40..49),
            (100..101),
            (52..60),
        ]
        assert_equal expected, s.transform_range_via_map(40..60, {:src=>50, :dest=>100, :range=>50..52, :size=>2})
    end

    focus
    def test_part2
        #assert_equal 46, Solution.new(data: SAMPLE_INPUT).part2
        assert_equal 456, Solution.new(data: real_input).part2
    end
end
