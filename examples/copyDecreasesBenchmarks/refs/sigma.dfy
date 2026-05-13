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
