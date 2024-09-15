advent = require('./advent');

test('base class has a part1', () => {
  new advent.base('foo').part1();
});

test('base class has a part2', () => {
  new advent.base('foo').part2();
});