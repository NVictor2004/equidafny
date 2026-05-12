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
  f_loop1(n + n, 0)
}

function f_loop1(i: int, j: int): int
{
  if i > 0 then
    f_loop1(i - 1, j + 1)
  else
    j
}

lemma equivalenceHelper(n: int, i: int, j: int)
  ensures f_loopM(n, i, j) == f_loop1(n + n - i, j)
  decreases n + n - i
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 0, 0);
}