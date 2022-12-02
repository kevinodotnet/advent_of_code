class Solution < AbstractSolution
  def parse
    @data.split("\n").map{|l| l.split(" ")}
  end

  def score(round)
    outcomes = {
      "A" => { # rock
        "X" => 3 + 1, # rock
        "Y" => 6 + 2, # paper
        "Z" => 0 + 3, # scissors
      },
      "B" => { # paper
        "X" => 0 + 1, # rock
        "Y" => 3 + 2, # paper
        "Z" => 6 + 3, # scissors
      },
      "C" => { # scissors
        "X" => 6 + 1, # rock
        "Y" => 0 + 2, # paper
        "Z" => 3 + 3, # scissors
      },
    }

    p1 = round[0]
    p2 = round[1]
    outcomes[p1][p2]
  end

  def part1
    parse.map{|r| score(r)}.sum
  end

  def part2
  end
end
