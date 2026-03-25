method g(n: int, s: int) returns (res: int)
{
  int r;
  var r := 0;
  if (n <= 0) {
    var r := s;
  } else {
    var r := g(n - 1, n + s);
  }
  return r;
}
method triangle(n: int) returns (res: int) {
  int r;
  var r := g(n, 0);
  return r;
}