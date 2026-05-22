// MODEL

function libM(x: int): int
{
  (x + 1) % 2
}

function oddM(x: int): int 
{
  if libM(x) == 0 then 1 
  else 0
}

// CANDIDATE

function lib1(x: int): int
  requires x > 0
{
  if x % 2 == 0 then 1 + lib1(x / 2)
  else 0
}

function odd1(x: int): int 
  requires x > 0
{
  if lib1(x) == 0 then 1 
  else 0
}

lemma lib1Helper(x: int)
  requires x > 0
  ensures x % 2 == 0 ==> lib1(x) > 0
{}

lemma equivalence(x: int)
  requires x > 0
  ensures oddM(x) == odd1(x)
{
  lib1Helper(x);
}
