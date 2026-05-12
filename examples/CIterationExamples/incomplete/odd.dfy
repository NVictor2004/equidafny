// MODEL

function LibM(x: int): int
{
  (x + 1) % 2
}

function ClientM(x: int): int 
{
  if LibM(x) == 0 then 
    1 
  else 
    0
}

// CANDIDATE

function Lib1(x: int): int
  requires x > 0
{
  if x % 2 == 0 then
    1 + Lib1(x / 2)
  else
    0
}

function Client1(x: int): int 
  requires x > 0
{
  if Lib1(x) == 0 then 
    1 
  else 
    0
}