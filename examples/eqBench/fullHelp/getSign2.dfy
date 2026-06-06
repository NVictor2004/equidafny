// MODEL

function libM(x: int): int {
  if (x == 0) then
     0
  else if (x < 0) then
     -1
  else
     1
}
function clientM(x: int): int {
  if (x > 0) then
    libM(x)
  else
  x
}

// CANDIDATE

function lib1(x: int): int {
  if (x <= 0) then
     -1
  else
     1
}
function client1(x: int): int {
  if (x > 0) then
    lib1(x)
  else
  x
}

lemma equivalence(x: int)
  ensures clientM(x) == client1(x)
{}
