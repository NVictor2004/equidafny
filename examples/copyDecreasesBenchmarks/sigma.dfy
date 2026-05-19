// MODEL

function solution_1(f: int -> int, a: int, b: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{
  if (a > b) then
    0
  else if (a == b) then
    f(a)
  else
    f(a) + solution_1(f, a + 1, b)
}
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

function s(a: int, b: int, f: int -> int, acc: int): int
  decreases(if (b == a) then 2 else if (b > a) then 2 + b - a else a - b)
{
  if (a > b) then acc else s(a + 1, b, f, acc + f(a))
}

function solution_3(f: int -> int, a: int, b: int): int {
  s(a, b, f, 0)
}

// CANDIDATE

// Needed to add a decreases clause here
function sigmaC(f: int -> int, a: int, b: int): int
  decreases b - a
{
  if (a > b) then 0 else f(a) + sigmaC(f, a + 1, b)
}

lemma equivalenceHelper3(f: int -> int, a: int, b: int, acc: int)
  ensures s(a, b, f, acc) == acc + sigmaC(f, a, b)
  decreases b - a
{}

lemma equivalence3(f: int -> int, a: int, b: int)
  ensures solution_3(f, a, b) == sigmaC(f, a, b)
{
  equivalenceHelper3(f, a, b, 0);
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
  decreases b - a
{
  if (a < b) {
    equivalenceHelper2(f, a, b);
  }
}

lemma equivalence1(f: int -> int, a: int, b: int)
  ensures solution_1(f, a, b) == sigmaC(f, a, b)
  decreases b - a
{}