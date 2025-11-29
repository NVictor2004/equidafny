













method sigma(f: int => int, a: int, b: int) returns (res: int) {
  decreases(if (b == a) int(2) else if (b > a) 2 + b - a else a - b) {

  method sigma_rec(
      sum: int,
      i: int,
      b: int,
      f: int => int
  ) returns (res: int) {
    decreases(if (b == i) int(2) else { var result := if (b > i) 2 + b - i else i - b); return result; }
    if (i < b) { var result := sigma_rec(sum + f(i), i + int(1), b, f); return result; }
    else if (i == b) { var result := sum + f(i)
    else int(0); return result; }
  }
  if (a > b) int(0) else { var result := sigma_rec(int(0), a, b, f); return result; }
}
