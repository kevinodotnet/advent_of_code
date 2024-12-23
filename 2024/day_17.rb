class Solution < AbstractSolution
  INSTRUCTIONS = {
    0 => :adv,
    1 => :bxl,
    2 => :bst,
    3 => :jnz,
    4 => :bxc,
    5 => :out,
    6 => :bdv,
    7 => :cdv
  }

  def parse
    @data = @data.split("\n\n")
    @a, @b, @c = @data.first.scan(/\d+/).map(&:to_i)
    @program = @data.last.scan(/\d+/).map(&:to_i)
    @output = []
  end

  # The adv instruction (opcode 0) performs division. The numerator is the value in the A register. The denominator is found by raising 2 to the power of the 
  # instruction's combo operand. (So, an operand of 2 would divide A by 4 (2^2); an operand of 5 would divide A by 2^B.) The result of the division operation is 
  # truncated to an integer and then written to the A register.
  def adv(i)
    @a = (@a / 2 ** combo_operand(i+1)).round
    i + 2
  end

  # The bxl instruction (opcode 1) calculates the bitwise XOR of register B and the instruction's literal operand, then stores the result in register B.
  def bxl(i)
    @b = @b ^ literal_operand(i+1)
    i + 2
  end
  
  # The bst instruction (opcode 2) calculates the value of its combo operand modulo 8 (thereby keeping only its lowest 3 bits), then writes that value to the B register.
  def bst(i)
    @b = combo_operand(i+1) % 8
    i + 2
  end
  
  # The jnz instruction (opcode 3) does nothing if the A register is 0. However, if the A register is not zero, it jumps by setting the instruction pointer to 
  # the value of its literal operand; if this instruction jumps, the instruction pointer is not increased by 2 after this instruction.
  def jnz(i)
    return i + 2 if @a == 0
    literal_operand(i+1)
  end
  
  # The bxc instruction (opcode 4) calculates the bitwise XOR of register B and register C, then stores the result in register B. 
  # (For legacy reasons, this instruction reads an operand but ignores it.)
  def bxc(i)
    @b = @b ^ @c
    i + 2
  end
  
  # The out instruction (opcode 5) calculates the value of its combo operand modulo 8, then outputs that value.
  #  (If a program outputs multiple values, they are separated by commas.)
  def out(i)
    @output << combo_operand(i+1) % 8
    i + 2
  end
  
  # The bdv instruction (opcode 6) works exactly like the adv instruction except that the result is stored in the B register.
  #  (The numerator is still read from the A register.)
  def bdv(i)
    @b = (@a / 2 ** combo_operand(i+1)).round
    i + 2
  end
  
  # The cdv instruction (opcode 7) works exactly like the adv instruction except that the result is stored in the C register.
  #  (The numerator is still read from the A register.)
  def cdv(i)
    @c = (@a / 2 ** combo_operand(i+1)).round
    i + 2
  end
  
  def literal_operand(i)
    @program[i]
  end

  def combo_operand(i)
    val = @program[i]
    return val if val <= 3
    return @a if val == 4
    return @b if val == 5
    return @c if val == 6
    binding.pry # impossible
  end

  def solve
    i = 0
    while i >= 0 && i < @program.size
      instruction = INSTRUCTIONS[@program[i]]
      # puts "i: #{i}, instruction: #{instruction}"
      i = send(instruction, i)
    end
  end

  def part1
    solve
    return @output.join(",")
  end

  def part2
  end
end
