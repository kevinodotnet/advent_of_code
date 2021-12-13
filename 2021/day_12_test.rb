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

    def test_sample_input_p2_a
        routes = <<~EOF
            start,A,b,A,b,A,c,A,end
            start,A,b,A,b,A,end
            start,A,b,A,b,end
            start,A,b,A,c,A,b,A,end
            start,A,b,A,c,A,b,end
            start,A,b,A,c,A,c,A,end
            start,A,b,A,c,A,end
            start,A,b,A,end
            start,A,b,d,b,A,c,A,end
            start,A,b,d,b,A,end
            start,A,b,d,b,end
            start,A,b,end
            start,A,c,A,b,A,b,A,end
            start,A,c,A,b,A,b,end
            start,A,c,A,b,A,c,A,end
            start,A,c,A,b,A,end
            start,A,c,A,b,d,b,A,end
            start,A,c,A,b,d,b,end
            start,A,c,A,b,end
            start,A,c,A,c,A,b,A,end
            start,A,c,A,c,A,b,end
            start,A,c,A,c,A,end
            start,A,c,A,end
            start,A,end
            start,b,A,b,A,c,A,end
            start,b,A,b,A,end
            start,b,A,b,end
            start,b,A,c,A,b,A,end
            start,b,A,c,A,b,end
            start,b,A,c,A,c,A,end
            start,b,A,c,A,end
            start,b,A,end
            start,b,d,b,A,c,A,end
            start,b,d,b,A,end
            start,b,d,b,end
            start,b,end
        EOF
        expected = routes.split("\n").map{|r| r.split(",")}.sort

        input = <<~EOF
            start-A
            start-b
            A-c
            A-b
            b-d
            A-end
            b-end
        EOF

        routes = Solution.new(input).routes(2)
        assert_equal expected.sort, routes.sort
        assert_equal 36, routes.count
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

    def test_sample_input_2_part2
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
        assert_equal 3509, Solution.new(input).routes(2).count
    end

    def test_part1
        assert_equal 4707, Solution.part1
    end

    def test_part1
        assert_equal 130493, Solution.part2
    end
end
