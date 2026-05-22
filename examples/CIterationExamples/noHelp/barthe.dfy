// MODEL

function fM(n: int, c: int): int {
  f_loopM(n, c, 0, 0, 0)
}

function f_loopM(n: int, c: int, i: int, j: int, x: int): int
  decreases n - i
{
  if i < n then
    var j := 5 * i + c;
    f_loopM(n, c, i + 1, j, x + j)
  else
    x
}

// CANDIDATE

function f1(n: int, c: int): int {
  f_loop1(n, c, 0, c, 0)
}

function f_loop1(n: int, c: int, i: int, j: int, x: int): int
  decreases n - i
{
  if i < n then
    f_loop1(n, c, i + 1, j + 5, x + j)
  else
    x
}