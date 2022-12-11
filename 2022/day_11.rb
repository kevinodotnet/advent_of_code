class Solution < AbstractSolution
  def parse
    monkeys = {}
    @data.split("\n\n").map{|m| m.split("\n")}.each do |m|
      monkey = m.shift.match(/Monkey (\d+)/)[1].to_i
      items = m.shift.match(/Starting items: (.*)/)[1].split(",").map(&:to_i)
      operation = m.shift.match(/Operation: new = (.*)/)[1]
      throw_test = m.shift.match(/Test: divisible by (\d+)/)[1].to_i
      if_true = m.shift.match(/If true: throw to monkey (\d+)/)[1].to_i
      if_false = m.shift.match(/If false: throw to monkey (\d+)/)[1].to_i
      monkeys[monkey] = {
        monkey: monkey,
        inspections: 0,
        items: items,
        operation: operation,
        throw_test: throw_test,
        if_true: if_true,
        if_false: if_false,
      }
    end
    monkeys
  end

  def round(monkeys)
    monkeys = monkeys.deep_dup
    monkeys.keys.sort.each do |m_index|
      m = monkeys[m_index]
      while i = m[:items].shift
        m[:inspections] += 1
        # do operation
        new_i = eval(m[:operation].gsub(/old/, i.to_s))
        # bored
        new_i /= 3
        # operation result
        test_result = new_i % m[:throw_test] == 0
        # throw to new monkey
        new_monkey = test_result ? m[:if_true] : m[:if_false]
        monkeys[new_monkey][:items] << new_i
      end
    end
    monkeys
  end

  def part1(count = 20)
    rounds = []
    # binding.pry
    rounds << parse
    count.times do |i|
      rounds << round(rounds.last)
    end
    rounds.last.map{|k, m| m[:inspections] }.max(2).inject(&:*)
  end

  def part2
    # parse
  end
end
