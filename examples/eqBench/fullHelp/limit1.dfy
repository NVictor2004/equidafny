// MODEL

function fM(n: int): int {
  var r: int := 0;
  if (n <= 1) then
    n
  else
    var r := fM(n - 1);
    n + r
}

// CANDIDATE

function f1(n: int): int {
  var r: int := 0;
  if (n <= 1) then
    n
  else
    var r := f1(n - 2);
    n + (n-1) + r
}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{}
