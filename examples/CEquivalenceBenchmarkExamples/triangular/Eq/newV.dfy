function g(n: int, s: int): int
{
  int r;
  r = 0;
  if (n <= 0) {
    r = s;
  } else {
    r = g(n - 1, n + s);
  }
  return r;
}
function triangle(n: int): int {
  int r;
  r = g(n, 0);
  return r;
}