require 'minitest/autorun'
require 'minitest/focus'

class SolutionTest < Minitest::Test
    def test_part1
        assert_equal 708, Solution.part1
    end

    def test_part2
        expected = <<~EOF
        #### ###  #    #  # ###  ###  #### #  # 
        #    #  # #    #  # #  # #  # #    #  # 
        ###  ###  #    #  # ###  #  # ###  #### 
        #    #  # #    #  # #  # ###  #    #  # 
        #    #  # #    #  # #  # # #  #    #  # 
        #### ###  ####  ##  ###  #  # #    #  # 
        EOF
        expected = expected.chomp
        actual = Solution.part2.chomp
        assert_equal expected, actual
    end

    def sample_input_1
        input = <<~EOF
            6,10
            0,14
            9,10
            0,3
            10,4
            4,11
            6,0
            6,12
            4,1
            0,13
            10,12
            3,4
            3,0
            8,4
            1,10
            2,14
            8,10
            9,0
            
            fold along y=7
            fold along x=5
        EOF
    end

    def test_example_1_data
        solution = Solution.parse(sample_input_1)
        expected = <<~EOF
            ...#..#..#.
            ....#......
            ...........
            #..........
            ...#....#.#
            ...........
            ...........
            ...........
            ...........
            ...........
            .#....#.##.
            ....#......
            ......#...#
            #..........
            #.#........
        EOF
        assert_equal expected.chomp, solution.board_as_str
        expected = [
            {
                axis: :y,
                at: 7
            },
            {
                axis: :x,
                at: 5
            }
        ]
        assert_equal expected, solution.folds
    end

    def test_non_middle_x
        input = <<~EOF
            10,0
            3,0

            fold along x=8
        EOF
        solution = Solution.parse(input)
        assert_equal "...#..#.".chomp, solution.fold.board_as_str.chomp
    end

    def test_non_middle_y
        input = <<~EOF
            0, 3
            0, 10

            fold along y=8
        EOF
        expected = <<~EOF
            .
            .
            .
            #
            .
            .
            #
            .
        EOF
        solution = Solution.parse(input)
        assert_equal expected.chomp, solution.fold.board_as_str.chomp
    end

    def test_example_1_fold_1_and_2
        solution = Solution.parse(sample_input_1)
        solution = solution.fold
        expected = <<~EOF
            #.##..#..#.
            #...#......
            ......#...#
            #...#......
            .#.#..#.###
            ...........
            ...........
        EOF
        assert_equal expected.chomp, solution.board_as_str
        assert_equal 17, solution.visible_count

        expected = <<~EOF
            #####
            #...#
            #...#
            #...#
            #####
            .....
            .....
        EOF
        solution = solution.fold
        assert_equal expected.chomp, solution.board_as_str
        assert_equal 16, solution.visible_count
    end
end
