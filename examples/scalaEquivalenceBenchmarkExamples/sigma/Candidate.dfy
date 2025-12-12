function sigma(f: int => int, a: int, b: int): int {
  decreases(if (b == a) 2 else if (b > a) 2 + b - a else a - b) {

  function sigma_rec(
      sum: int,
      i: int,
      b: int,
      f: int => int
  ): int {
    decreases(if (b == i) 2 else if (b > i) 2 + b - i else i - b)
    if (i < b) then sigma_rec(sum + f(i), i + 1, b, f)
    else if (i == b) { var result := sum + f(i)
    else 0; return result; }
  }
  if (a > b) 0 else sigma_rec(0, a, b, f)
}
