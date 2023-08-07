d01 = require('./d01')

sample = `1000
2000
3000

4000

5000
6000

7000
8000
9000

10000`

test('part1 sample', () => {
  expect(new d01.solution(sample).part1()).toBe(24000);
});

test('d01 class has a part2', () => {
  // new d01.solution(sample).part2();
});