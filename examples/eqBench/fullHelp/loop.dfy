// MODEL

function fM(n: real): real {
  f_loopM(n, 0.0, 0.0)
}

function f_loopM(n: real, i: real, j: real): real
  decreases n - i
{
  if i <= n then
    f_loopM(n, i + 1.0, j + 1.0)
  else
    j
}

// CANDIDATE

function f1(n: real): real {
  f_loop1(n, n, 0.0)
}

function f_loop1(n: real, i: real, j: real): real
{
  if i >= 0.0 then
    f_loop1(n, i - 1.0, j + 1.0)
  else
    j
}

lemma equivalenceHelper(n: real, i: real, j: real)
  ensures f_loopM(n, i, j) == f_loop1(n, n - i, j)
  decreases n - i
{}

lemma equivalence(n: real)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 0.0, 0.0);
}