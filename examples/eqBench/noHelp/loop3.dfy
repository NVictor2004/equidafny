// MODEL

function fM(n: int): int {
  var actualN := if n < 1 then 1 else n;
  
  f_loopM(actualN, 1, 0)
}

function f_loopM(n: int, i: int, j: int): int
  decreases n - i
{
  if i <= n then
    f_loopM(n, i + 1, j + 2)
  else
    j
}

// CANDIDATE

function f1(n: int): int {
  var actualN := if n < 1 then 1 else n;
  
  f_loop1(actualN, 1, 2)
}

function f_loop1(n: int, i: int, j: int): int
  decreases n - i
{
  if i < n then
    f_loop1(n, i + 1, j + 2)
  else
    j
}