// MODEL

function fM(n: int): int {
  f_loopM(n, 0, 0)
}

function f_loopM(n: int, i: int, j: int): int
  decreases n + n - i
{
  if i < n + n then
    f_loopM(n, i + 1, j + 1)
  else
    j
}

// CANDIDATE

function f1(n: int): int {
  f_loop1(n + 1, 0)
}

function f_loop1(i: int, j: int): int
{
  if i > 0 then
    f_loop1(i - 1, j + 2)
  else
    j
}