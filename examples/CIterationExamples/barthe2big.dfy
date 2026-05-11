// MODEL

// Main entry point
function fM(n: int): int {
  // 1. Run the first loop (i=1, x=1)
  var x_after_first_loop := f_loop1M(n, 1, 1);
  
  // 2. Run the second loop starting with i=0 and the previous x
  f_loop2M(n, 0, x_after_first_loop)
}

// First loop: while (i <= n) { x = x * 5; i++; }
function f_loop1M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    f_loop1M(n, i + 1, x * 5)
  else
    x
}

// Second loop: while (i <= n) { x = x + i; i++; }
function f_loop2M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    f_loop2M(n, i + 1, x + i)
  else
    x
}

// CANDIDATE

// Main entry point equivalent to the C function f(n)
function f1(n: int): int {
  // 1. Run the first loop (i=1, x=1)
  var x1 := PowerLoop1(n, 1, 1);
  
  // 2. Run the second loop starting with i=1 and the result of the first loop
  SumLoop1(n, 1, x1)
}

// First loop: x = x * 5; i++;
function PowerLoop1(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then 
    PowerLoop1(n, i + 1, x * 5)
  else 
    x
}

// Second loop: x = x + i; i++;
function SumLoop1(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then 
    SumLoop1(n, i + 1, x + i)
  else 
    x
}