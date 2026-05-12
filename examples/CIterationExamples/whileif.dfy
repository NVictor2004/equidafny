// MODEL

function fM(t: int, c: int): int {
  if 0 < t then
    f_loopM(c, 0)
  else
    0
}

function f_loopM(c: int, x: int): int
{
  if 0 < c then
    f_loopM(c - 1, x + 1)
  else
    x
}

// CANDIDATE

function f1(t: int, c: int): int
  requires t > 0
{
  f_loop1(t, c, 0)
}

function f_loop1(t: int, c: int, x: int): int
  requires t > 0
{
  if 0 < c then
    if 0 < t then
      f_loop1(t, c - 1, x + 1)
    else
      f_loop1(t, c, x)
  else
    x
}

lemma equivalenceLoop(t: int, c: int, x: int)
  requires t > 0
  ensures f_loopM(c, x) == f_loop1(t, c, x)
{}

lemma equivalence(t: int, c: int)
  requires t > 0
  ensures fM(t, c) == f1(t, c)
{
  equivalenceLoop(t, c, 0);
}