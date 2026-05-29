// MODEL

function solution_2(f: int -> int, a: int, b: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{
  if (a > b) then
    0
  else if (a == b) then
    f(a)
  else
    f(b) + solution_2(f, a, b - 1)
}

// CANDIDATE

// Needed to add a decreases clause here
function sigmaC(f: int -> int, a: int, b: int): int
  decreases b - a
{
  if (a > b) then 0 else f(a) + sigmaC(f, a + 1, b)
}

lemma equivalenceHelper2(f: int -> int, a: int, b: int)
  requires a <= b
  ensures sigmaC(f, a, b) == sigmaC(f, a, b - 1) + f(b)
  decreases b - a
{
  if (a != b) {
    equivalenceHelper2(f, a + 1, b);
  }
}

lemma equivalence2(f: int -> int, a: int, b: int)
  ensures solution_2(f, a, b) == sigmaC(f, a, b)
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{
  if (a < b) {
    equivalenceHelper2(f, a, b);
  }
}