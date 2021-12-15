require 'minitest/autorun'
require 'minitest/focus'

class SolutionTest < Minitest::Test
    def test_part1
        assert_equal 3342, Solution.part1
    end

    def test_part2
        assert_equal 3776553567525, Solution.part2
    end

    def input
        input = <<~EOF
            NNCB

            CH -> B
            HH -> N
            CB -> H
            NH -> C
            HB -> C
            HC -> B
            HN -> C
            NN -> C
            BH -> H
            NC -> B
            NB -> B
            BN -> B
            BB -> N
            BC -> B
            CC -> N
            CN -> C
        EOF
    end

    def test_toy_1
        input = <<~EOF
            AABB

            AA -> Z
            AZ -> H
        EOF
        solution = Solution.parse(input)
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 0, solution.count("Z")
        assert_equal 0, solution.count("H")
        solution = solution.insert
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 1, solution.count("Z")
        assert_equal 0, solution.count("H")
        solution = solution.insert
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 1, solution.count("Z")
        assert_equal 1, solution.count("H")
    end

    def test_toy_2
        input = <<~EOF
            AABB

            AA -> Z
            AZ -> H
            BB -> C
        EOF
        solution = Solution.parse(input)
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 0, solution.count("C")
        assert_equal 0, solution.count("Z")
        assert_equal 0, solution.count("H")
        solution = solution.insert
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 1, solution.count("C")
        assert_equal 1, solution.count("Z")
        assert_equal 0, solution.count("H")
        solution = solution.insert
        assert_equal 2, solution.count("A")
        assert_equal 2, solution.count("B")
        assert_equal 1, solution.count("C")
        assert_equal 1, solution.count("Z")
        assert_equal 1, solution.count("H")
    end

    def test_parse
        solution = Solution.parse(input)

        expected = {
            "CH" => "B",
            "HH" => "N",
            "CB" => "H",
            "NH" => "C",
            "HB" => "C",
            "HC" => "B",
            "HN" => "C",
            "NN" => "C",
            "BH" => "H",
            "NC" => "B",
            "NB" => "B",
            "BN" => "B",
            "BB" => "N",
            "BC" => "B",
            "CC" => "N",
            "CN" => "C",
        }
        assert_equal expected, solution.insertions
    end

    def test_insertions_1
        solution = Solution.parse(input)
        solution.insert
        [
            "NNCB",
            "NCNBCHB",
            "NBCCNBBBCBHCB",
            "NBBBCNCCNBBNBNBBCHBHHBCHB",
            "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB",
        ].each do |input|
            input.split("").each do |c|
                expected = input.count(c)
                assert_equal expected, solution.count(c), message: "c: #{c} input: #{input}"
            end
            solution = solution.insert
        end
    end    

    def test_insertions_1
        solution = Solution.parse(input)
        solution = solution.insert
        $glob = true
        solution = solution.insert
        "NBCCNBBBCBHCB".split("").each do |c|
            expected = "NBCCNBBBCBHCB".count(c)
            assert_equal expected, solution.count(c), message: "c: #{c}"
        end
        $glob = false
    end    

    def test_insertions_2
        solution = Solution.parse(input)
        10.times { solution = solution.insert }
        assert_equal 1749, solution.count("B")
        assert_equal 298, solution.count("C")
        assert_equal 161, solution.count("H")
        assert_equal 865, solution.count("N")

        fewest = solution.counts.invert.min.first
        most = solution.counts.invert.max.first
        diff = most - fewest
        assert_equal 1588, diff
    end

    def test_40_times
        solution = Solution.parse(input)
        40.times { solution = solution.insert }
        assert_equal 2192039569602, solution.count("B")
        assert_equal 3849876073, solution.count("H")
        assert_equal 2192039569602, solution.most
        assert_equal 3849876073, solution.least
    end
end
