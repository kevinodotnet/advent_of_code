class Solution < AbstractSolution
  def parse
    monkeys = {}
    @data.split("\n\n").map{|m| m.split("\n")}.each do |m|
      monkey = m.shift.match(/Monkey (\d+)/)[1].to_i
      items = m.shift.match(/Starting items: (.*)/)[1].split(",").map(&:to_i)
      op, op_val = m.shift.match(/Operation: new = (.*)/)[1].split(" ").sort
      throw_test = m.shift.match(/Test: divisible by (\d+)/)[1].to_i
      if_true = m.shift.match(/If true: throw to monkey (\d+)/)[1].to_i
      if_false = m.shift.match(/If false: throw to monkey (\d+)/)[1].to_i
      monkeys[monkey] = {
        monkey: monkey,
        inspections: 0,
        items: items,
        op: op.to_sym,
        op_val: op_val,
        throw_test: throw_test,
        if_true: if_true,
        if_false: if_false,
      }
    end
    monkeys
  end

  def round(monkeys, worry)
    lcm = monkeys.map{|k, m| m[:throw_test]}.inject(&:*)
    monkeys = monkeys.deep_dup
    monkeys.keys.sort.each do |m_index|
      m = monkeys[m_index]
      while i = m[:items].shift
        m[:inspections] += 1
        op_val = m[:op_val].gsub(/old/, i.to_s).to_i
        new_i = i.send(m[:op], op_val)
        new_i = if worry
          new_i /= 3 
        else
          new_i = new_i % lcm
        end
        test_result = new_i % m[:throw_test] == 0
        new_monkey = test_result ? m[:if_true] : m[:if_false]
        monkeys[new_monkey][:items] << new_i
      end
    end
    monkeys
  end

  def solve(count, worry)
    cur_round = parse
    count.times do |i|
      cur_round = round(cur_round, worry)
    end
    cur_round.map{|k, m| m[:inspections] }.max(2).inject(&:*)
  end

  def part1
    solve(20, true)
  end

  def part2
    solve(10000, false)
  end
end
