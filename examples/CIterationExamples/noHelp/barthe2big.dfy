// MODEL

function fM(n: int): int {
  var x_after_first_loop := f_loop1M(n, 1, 1);
  
  f_loop2M(n, 0, x_after_first_loop)
}

function f_loop1M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    f_loop1M(n, i + 1, x * 5)
  else
    x
}

function f_loop2M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    f_loop2M(n, i + 1, x + i)
  else
    x
}

// CANDIDATE

function f1(n: int): int {
  var x1 := PowerLoop1(n, 1, 1);
  
  SumLoop1(n, 1, x1)
}

function PowerLoop1(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then 
    PowerLoop1(n, i + 1, x * 5)
  else 
    x
}

function SumLoop1(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then 
    SumLoop1(n, i + 1, x + i)
  else 
    x
}