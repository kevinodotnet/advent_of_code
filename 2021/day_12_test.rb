require 'minitest/autorun'
require 'minitest/focus'

class SolutionTest < Minitest::Test
    def test_sample_input
        routes = <<~EOF
            start,HN,dc,HN,end
            start,HN,dc,HN,kj,HN,end
            start,HN,dc,end
            start,HN,dc,kj,HN,end
            start,HN,end
            start,HN,kj,HN,dc,HN,end
            start,HN,kj,HN,dc,end
            start,HN,kj,HN,end
            start,HN,kj,dc,HN,end
            start,HN,kj,dc,end
            start,dc,HN,end
            start,dc,HN,kj,HN,end
            start,dc,end
            start,dc,kj,HN,end
            start,kj,HN,dc,HN,end
            start,kj,HN,dc,end
            start,kj,HN,end
            start,kj,dc,HN,end
            start,kj,dc,end
        EOF
        expected = routes.split("\n").map{|r| r.split(",")}.sort

        input = <<~EOF
            dc-end
            HN-start
            start-kj
            dc-start
            dc-HN
            LN-dc
            HN-end
            kj-sa
            kj-HN
            kj-dc
        EOF

        assert_equal expected, Solution.new(input).routes.sort
    end

    def test_sample_input_2
        input = <<~EOF
            fs-end
            he-DX
            fs-he
            start-DX
            pj-DX
            end-zg
            zg-sl
            zg-pj
            pj-he
            RW-he
            fs-DX
            pj-RW
            zg-RW
            start-pj
            he-WI
            zg-he
            pj-fs
            start-RW
        EOF

        assert_equal 226, Solution.new(input).routes.count
    end

    def test_part1
        assert_equal 4707, Solution.part1
    end

    def test_part1
        Solution.part2
    end
end
