// MODEL

// This one is expected to timeout, but we want to test that permutation of arguments
// for auxiliary functions does not go wrong when doing a "model first"
// and "candidate first" induction strategy

function s(a: int, b: int, f: int -> int, acc: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b) {
  if (a > b) then acc else s(a + 1, b, f, acc + f(a))
}

function sigmaM(f: int -> int, a: int, b: int): int {
  s(a, b, f, 0)
}

// CANDIDATE

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

function sigma1(f: int -> int, a: int, b: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b) {
  if (a > b) then 0 else sigma_rec(0, a, b, f)
}

lemma equivalenceSigmaRec_s(sum: int, i: int, b: int, f: int -> int)
  decreases(if (b == i) then 2 else if (b > i) then 2 + b - i else i - b)
  requires i <= b
  ensures (sigma_rec(sum, i, b, f) == s(i, b, f, sum))
{}

lemma equivalenceSigma1(f: int -> int, a: int, b: int)
  ensures (sigma1(f, a, b) == sigmaM(f, a, b))
{
  if (a <= b) {equivalenceSigmaRec_s(0, a, b, f);}
}
