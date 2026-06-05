// MODEL

function libM(x: int): int {
  if (x > 10) then
    11
  else
    x
}
function clientM(x: int): int {
  if (x < -100 || x > 100) then
    x
  else
    if (x > libM(x)) then x
    else libM(x)
}

// CANDIDATE

function lib1(x: int): int {
  if (x > 11) then
    11
  else
    x - 1
}
function client1(x: int): int {
  if (x < -100 || x > 100) then
    x
  else
    if (x > lib1(x)) then x
    else lib1(x)
}