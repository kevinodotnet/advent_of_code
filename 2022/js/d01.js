advent = require('./advent');

class Solution extends advent.base {
  parse() {
    return this.data.split("\n\n").map((lines) => lines.split("\n").map((x) => parseInt(x)));
  }
  part1() {
    var snacks = this.parse();
    snacks = snacks.map((t) => t.reduce((acc, i) => acc + i, 0)).sort(function(a, b){return a-b});
    return snacks.pop();
  }
}

exports.solution = Solution;