// MODEL

function fM(n: int): int {
  var r := 0;
  if (n <= 1) then
    n
  else
    var r := fM(n - 1);
    n + r
}

// CANDIDATE

function f1(n: int): int
{
  var r := 0;
  if (n <= 1) then
    n
  else
    var r := f1(n - 1);
    if (r >= 0) then
      n + r
    else r
}

lemma equivalenceHelper(n: int)
  requires n >= 0
  ensures f1(n) >= 0
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  if (n >= 0) { equivalenceHelper(n); }
}
