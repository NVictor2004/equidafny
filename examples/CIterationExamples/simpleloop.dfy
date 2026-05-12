// MODEL

function fM(z: int): int {
  f_loopM(0)
}

function f_loopM(i: int): int
  decreases 11 - i
{
  if i <= 10 then 
    f_loopM(i + 1)
  else 
    i
}

// CANDIDATE

function f1(z: int): int {
  f_loop1(1)
}

function f_loop1(i: int): int
  decreases 11 - i
{
  if i <= 10 then 
    f_loop1(i + 1)
  else 
    i
}

lemma equivalence(z: int)
  ensures fM(z) == f1(z)
{}