// MODEL

function helperLibM(x: int): int
  requires x > 0
{
  if x % 2 == 0 then 1 + helperLibM(x / 2)
  else 0
}

function libM(x: int): int
  requires x > 0
{
  helperLibM(x) + 1
}

function oddM(x: int): int 
  requires x > 0
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
