// MODEL

function LibM(x: int): int
{
  if x < 0 then
    -x
  else
    x
}

function ClientM(x: int): int {
  if x > 0 then
    -LibM(-x)
  else
    LibM(x)
}

// CANDIDATE

function Lib1(x: int): int
  decreases -x
{
  if x < 0 then
    1 + Lib1(x + 1)
  else
    0
}

function Client1(x: int): int {
  if x > 0 then
    -Lib1(-x)
  else
    Lib1(x)
}