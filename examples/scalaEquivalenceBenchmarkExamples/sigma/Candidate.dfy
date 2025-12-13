
function sigma_rec(
      sum: int,
      i: int,
      b: int,
      f: int -> int
  ): int
    decreases(if (b == i) then 2 else if (b > i) then 2 + b - i else i - b) {
    if (i < b) then sigma_rec(sum + f(i), i + 1, b, f)
    else if (i == b) then sum + f(i)
    else 0
  }

function sigma(f: int -> int, a: int, b: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b) {
  if (a > b) then 0 else sigma_rec(0, a, b, f)
}
