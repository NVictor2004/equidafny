// MODEL

// The recursive function implementing the logic of lib(int x)
function LibM(x: int): int
{
  (x + 1) % 2
}

// The client function
function ClientM(x: int): int 
{
  if LibM(x) == 0 then 
    1 
  else 
    0
}

// CANDIDATE

// The recursive function implementing the logic of lib(int x)
function Lib1(x: int): int
  requires x > 0
{
  if x % 2 == 0 then
    1 + Lib1(x / 2) // counter++ and recurse
  else
    0 // Base case: x is odd, counter starts at 0
}

// The client function
function Client1(x: int): int 
  requires x > 0
{
  if Lib1(x) == 0 then 
    1 
  else 
    0
}