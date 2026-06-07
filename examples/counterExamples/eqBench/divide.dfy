// MODEL

function libM(x: int, y: int): int
  requires y != 0
{ 
  x / y
}
function clientM(c: int, d: int): int {
  if (d == 0) then
    0
  else
  libM(c, d)
}

// CANDIDATE

function lib1(x: int, y: int): int { x * y }
function client1(c: int, d: int): int {
  if (d == 0) then
    0
  else
  lib1(c, d)
}