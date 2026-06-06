// MODEL

function libM(x: int): int {
  if (x == 0) then
     0
  else if (x < 0) then
     -1
  else
     1
}
function clientM(x: int): int{
  libM(x)
}

// CANDIDATE

function lib1(x: int): int {
  if (x <= 0) then
     -1
  else
     1
}
function client1(x: int): int{
  lib1(x)
}