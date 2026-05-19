// MODEL

function solution_1(f: int -> int, a: int, b: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{
  if (a > b) then 0
  else if (a == b) then f(a)
  else f(a) + solution_1(f, a + 1, b)
}

// CANDIDATE

// Needed to add a decreases clause here
function sigmaC(f: int -> int, a: int, b: int): int
  decreases b - a
{
  if (a > b) then 0 else f(a) + sigmaC(f, a + 1, b)
}

lemma equivalence1(f: int -> int, a: int, b: int)
  ensures solution_1(f, a, b) == sigmaC(f, a, b)
  decreases b - a
{}