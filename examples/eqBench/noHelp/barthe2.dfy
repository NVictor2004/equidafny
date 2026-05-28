// MODEL

function fM(n: int): int {
  f_loopM(n, 0, 0)
}

function f_loopM(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    f_loopM(n, i + 1, x + i)
  else
    x
}

// CANDIDATE

function f1(n: int): int {
  f_loop1(n, 1, 0)
}

function f_loop1(n: int, j: int, x: int): int
  decreases n - j
{
  if j <= n then 
    f_loop1(n, j + 1, x + j)
  else 
    x
}
