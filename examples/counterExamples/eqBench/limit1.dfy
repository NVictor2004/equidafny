// MODEL

function fM(n: int): int {
  if (n <= 1) then
    n
  else
    var r := fM(n - 1);
    n + r
}

// CANDIDATE

function f1(n: int): int {
  if (n <= 1) then
    n
  else
    var r := f1(n - 3);
    n + (n-1) + r
}