// oldV.dfy

method old_g(n: int) returns (res: int)
{
  var r := 0;
  if (n <= 0) {
    var r := 0;
  } else {
    var r := g(n - 1);
    var r := n + r;
  }
  return r;
}
method old_triangle(n: int) returns (res: int) {
  var r := g(n);
  return r;
}
// newV.dfy

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