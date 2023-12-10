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

    def test_transform_range_via_map1a
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse

        expected = [(81..95)]
        assert_equal expected, s.transform_range_via_map(79..93, {:src=>50, :dest=>52, :size=>48})
    end

    def test_transform_range_via_map1b
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse

        expected = [(10..20)]
        assert_equal expected, s.transform_range_via_map(10..20, {:src=>50, :dest=>52, :size=>48})
    end

    def test_transform_range_via_map1c
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse

        expected = [
            (40..49),
            (100..101),
            (52..60),
        ]
        assert_equal expected, s.transform_range_via_map(40..60, {:src=>50, :dest=>100, :size=>2})
    end

    def test_transform_range_via_map2d
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse
        expected = [
            (110..119),
            (30..30)
        ]
        assert_equal expected, s.transform_range_via_map(20..30, {:src=>10, :dest=>100, :size=>20})
    end

    def test_transform_range_via_map3e
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse
        expected = [
            (40..59),
            (100..100)
        ]
        assert_equal expected, s.transform_range_via_map(40..60, {:src=>60, :dest=>100, :size=>20})
    end

    def test_transform_range_via_map4f
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse
        expected = [
            (119..119),
            (80..80)
        ]
        assert_equal expected, s.transform_range_via_map(79..80, {:src=>60, :dest=>100, :size=>20})
    end

    def test_no_intersect
        expected = [
            10..100
        ]
        assert_equal expected, test_sol.transform_range_via_map(10..100, {:src=>1000, :dest=>110, :size=>50})
    end

    def test_range_within_map
        expected = [
            115..116
        ]
        assert_equal expected, test_sol.transform_range_via_map(1005..1006, {:src=>1000, :dest=>110, :size=>50})
    end

    def test_range_bigger_map_overlap_start
        expected = [
            2005..2009,
            110..1000
        ]
        assert_equal expected, test_sol.transform_range_via_map(105..1000, {:src=>100, :dest=>2000, :size=>10})
    end

    def test_range_bigger_map_overlap_end
        expected = [
            105..994,
            2000..2005
        ]
        assert_equal expected, test_sol.transform_range_via_map(105..1000, {:src=>995, :dest=>2000, :size=>10})
    end

    def test_range_smaller_map_overlap_start
        expected = [
            2100..2199,
            1100..2000
        ]
        assert_equal expected, test_sol.transform_range_via_map(1000..2000, {:src=>900, :dest=>2000, :size=>200})
    end

    def test_range_smaller_map_overlap_end
        expected = [
            2150..2199,
            1100..2000
        ]
        assert_equal expected, test_sol.transform_range_via_map(1050..2000, {:src=>900, :dest=>2000, :size=>200})
    end

    def test_part2
        assert_equal 46, Solution.new(data: SAMPLE_INPUT).part2
        refute_equal 1549152, Solution.new(data: real_input).part2
    end

    #
    # test_same_size
    #

    def test_same_size_no_intersection
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 100,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_after_range_but_touches
        expected = [
            10..19,
            200..200
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 20,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_after_range_overlaps_more
        expected = [
            10..16,
            200..203
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 17,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_after_range_overlaps_but_one
        expected = [
            10..10,
            200..209
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 11,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_at_range
        expected = [
            200..210
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 10,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_by_one
        expected = [
            201..210,
            20..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 9,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_by_two
        expected = [
            202..210,
            19..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 8,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_all_but_two
        expected = [
            208..210,
            13..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 2,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_all_but_one
        expected = [
            209..210,
            12..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 1,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_touching
        expected = [
            210..210,
            11..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 0,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_same_size_map_before_range_not_touching
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => -10,
                :dest => 200,
                :size => 11
            }
        )
    end

    #
    # test_map_bigger
    #

    def test_map_bigger_no_intersection
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 100,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_after_range_but_touches
        expected = [
            10..19,
            200..200
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 20,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_after_range_overlaps_more
        expected = [
            10..16,
            200..203
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 17,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_after_range_overlaps_but_one
        expected = [
            10..10,
            200..209
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 11,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_at_range
        expected = [
            200..210
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 10,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_before_range_by_one
        expected = [
            201..211,
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 9,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_before_range_by_two
        expected = [
            202..212,
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 8,
                :dest => 200,
                :size => 100
            }
        )
    end

    def test_map_bigger_map_before_range_not_touching
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => -1000,
                :dest => 200,
                :size => 100
            }
        )
    end

    #
    # test_map_smaller
    #

    def test_map_smaller_no_intersection
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 100,
                :dest => 200,
                :size => 5
            }
        )
    end

    def test_map_smaller_map_after_range_but_touches
        expected = [
            10..19,
            200..200
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 20,
                :dest => 200,
                :size => 5
            }
        )
    end

    def test_map_smaller_map_after_range_overlaps_more
        expected = [
            10..16,
            200..203
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 17,
                :dest => 200,
                :size => 5
            }
        )
    end

    def test_map_smaller_map_after_range_overlaps_but_one
        expected = [
            10..10,
            200..204,
            16..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 11,
                :dest => 200,
                :size => 5
            }
        )
    end

    def test_map_smaller_map_at_range
        expected = [
            200..204,
            15..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 10,
                :dest => 200,
                :size => 5
            }
        )
    end

    def test_map_smaller_map_before_range_not_touching
        expected = [
            10..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => -10,
                :dest => 200,
                :size => 5
            }
        )
    end

    #
    # range.size = 1
    #

    def test_range_size_one_map_before_touches
        expected = [
            210..210
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..10,
            {
                :src  => 0,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_range_size_one_map_overlaps
        expected = [
            205..205
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..10,
            {
                :src  => 5,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_range_size_one_map_after_touches
        expected = [
            200..200
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..10,
            {
                :src  => 10,
                :dest => 200,
                :size => 11
            }
        )
    end

    #
    # map_size_one
    #

    def test_map_size_one_at_range_0
        expected = [
            200..200,
            11..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 10,
                :dest => 200,
                :size => 1
            }
        )
    end

    def test_map_size_one_at_range_1
        expected = [
            10..10,
            200..200,
            12..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 11,
                :dest => 200,
                :size => 1
            }
        )
    end

    def test_map_size_one_at_range_last_minus_1
        expected = [
            10..18,
            200..200,
            20..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 19,
                :dest => 200,
                :size => 1
            }
        )
    end

    def test_map_size_one_at_range_last
        expected = [
            10..19,
            200..200,
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 20,
                :dest => 200,
                :size => 1
            }
        )
    end

    #
    # range.size = 2
    #

    def test_range_size_two_map_before_touches
        expected = [
            210..210,
            11..11
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..11,
            {
                :src  => 0,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_range_size_two_map_overlaps
        expected = [
            205..206
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..11,
            {
                :src  => 5,
                :dest => 200,
                :size => 11
            }
        )
    end

    def test_range_size_two_map_after_touches
        expected = [
            10..10,
            200..200
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..11,
            {
                :src  => 11,
                :dest => 200,
                :size => 11
            }
        )
    end

    #
    # map_size_two
    #

    def test_map_size_two_at_range_0
        expected = [
            200..201,
            12..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 10,
                :dest => 200,
                :size => 2
            }
        )
    end

    def test_map_size_two_at_range_1
        expected = [
            10..10,
            200..201,
            13..20
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 11,
                :dest => 200,
                :size => 2
            }
        )
    end

    def test_map_size_two_at_range_last_minus_1
        expected = [
            10..18,
            200..201,
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 19,
                :dest => 200,
                :size => 2
            }
        )
    end

    def test_map_size_two_at_range_last
        expected = [
            10..19,
            200..200,
        ]
        assert_equal expected, test_sol.transform_range_via_map(
            10..20,
            {
                :src  => 20,
                :dest => 200,
                :size => 2
            }
        )
    end

    private

    def test_sol
        s = Solution.new(data: SAMPLE_INPUT)
        s.parse
        s
    end
end
