


method sigma(f: int => int, a: int, b: int) returns (res: int) {
  decreases(if (b == a) int(2) else if (b > a) 2 + b - a else a - b) {

  method sigma_rec(
      sum: int,
      i: int,
      b: int,
      f: int => int
  ) returns (res: int) {
    decreases(if (b == i) int(2) else if (b > i) 2 + b - i else i - b)
    if (i < b) sigma_rec(sum + f(i), i + int(1), b, f)
    else if (i == b) sum + f(i)
    else int(0)
  }
  if (a > b) int(0) else sigma_rec(int(0), a, b, f)
}

