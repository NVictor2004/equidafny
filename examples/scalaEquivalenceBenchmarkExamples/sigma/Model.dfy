
// This one is expected to timeout, but we want to test that permutation of arguments
// for auxiliary functions does not go wrong when doing a "model first"
// and "candidate first" induction strategy

  method sigma(f: int => int, a: int, b: int): int = {
    method s(a: int, b: int, f: int => int, acc: int): int = {
      decreases(if (b == a) int(2) else if (b > a) 2 + b - a else a - b)
      if (a > b) acc else s(a + int(1), b, f, acc + f(a))
    }

    s(a, b, f, int(0))
  }
}
