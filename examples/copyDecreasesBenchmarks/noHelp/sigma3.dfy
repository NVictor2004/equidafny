// MODEL

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