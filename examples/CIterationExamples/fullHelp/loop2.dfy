// MODEL

function fM(n: int): int {
  f_loopM(n, 1, 0)
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
  f_loop1(n, 0, 0)
}

function f_loop1(n: int, i: int, j: int): int
  decreases n - i 
{
  if i < n then
    f_loop1(n, i + 1, j + 2)
  else
    j
}

lemma equivalenceHelper(n: int, i: int, j: int)
  ensures f_loop1(n, i, j) == f_loopM(n, i + 1, j)
  decreases n - i
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 0, 0);
}