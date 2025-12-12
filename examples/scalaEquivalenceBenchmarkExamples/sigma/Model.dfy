// This one is expected to timeout, but we want to test that permutation of arguments
// for auxiliary functions does not go wrong when doing a "model first"
// and "candidate first" induction strategy

function sigma(f: int => int, a: int, b: int): int {
  function s(a: int, b: int, f: int => int, acc: int): int {
    decreases(if (b == a) 2 else if (b > a) then 2 + b - a else a - b)
    if (a > b) acc else s(a + 1, b, f, acc + f(a))
  }

  s(a, b, f, 0)
}
