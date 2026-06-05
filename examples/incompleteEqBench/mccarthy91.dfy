// MODEL

function fM(a: int): int {
  var r := 0;
  if (a > 100) then
    a - 10
  else
    var r := fM(a + 11);
    fM(r)
}

// CANDIDATE

function f1(x: int): int {
  if (x < 101) then
    var r := f1(11 + x);
    f1(r)
  else
    x - 10
}