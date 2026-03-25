method g(n: int) returns (res: int)
{
  int r;
  var r := 0;
  if (n <= 0) {
    var r := 0;
  } else {
    var r := g(n - 1);
    var r := n + r;
  }
  return r;
}
method triangle(n: int) returns (res: int) {
  int r;
  var r := g(n);
  return r;
}