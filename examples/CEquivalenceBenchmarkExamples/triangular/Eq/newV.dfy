method new_g(n: int, s: int) returns (res: int)
{
  var r := 0;
  if (n <= 0) {
    var r := s;
  } else {
    var r := g(n - 1, n + s);
  }
  return r;
}
method new_triangle(n: int) returns (res: int) {
  var r := g(n, 0);
  return r;
}