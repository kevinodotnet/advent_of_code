require 'minitest/autorun'
require 'minitest/focus'

class SolutionTest < Minitest::Test
    def test_part1
        assert_equal 3342, Solution.part1
    end

    def test_part2
        Solution.part2
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

    def test_parse
        solution = Solution.parse(input)
        assert_equal "NNCB", solution.template

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
        assert_equal "NNCB", solution.template
        solution = solution.insert
        assert_equal "NCNBCHB", solution.template
        solution = solution.insert
        assert_equal "NBCCNBBBCBHCB", solution.template
        solution = solution.insert
        assert_equal "NBBBCNCCNBBNBNBBCHBHHBCHB", solution.template
        solution = solution.insert
        assert_equal "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB", solution.template
    end

    def test_insertions_2
        solution = Solution.parse(input)
        5.times { solution = solution.insert }
        assert_equal 97, solution.template.length
        5.times { solution = solution.insert }
        assert_equal 3073, solution.template.length
        assert_equal 1749, solution.template.split("").select{|c| c == "B"}.count
        assert_equal 298, solution.template.split("").select{|c| c == "C"}.count
        assert_equal 161, solution.template.split("").select{|c| c == "H"}.count
        assert_equal 865, solution.template.split("").select{|c| c == "N"}.count

        fewest = solution.template.split("").group_by(&:to_s).map { |a| [a[0], a[1].count] }.to_h.invert.min
        most = solution.template.split("").group_by(&:to_s).map { |a| [a[0], a[1].count] }.to_h.invert.max
        diff = most.first - fewest.first
        assert_equal 1588, diff
    end
end
