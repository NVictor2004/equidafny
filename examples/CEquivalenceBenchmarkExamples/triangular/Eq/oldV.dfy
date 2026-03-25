function g(n: int): int
{
  int r;
  r = 0;
  if (n <= 0) {
    r = 0;
  } else {
    r = g(n - 1);
    r = n + r;
  }
  return r;
}
function triangle(n: int): int {
  int r;
  r = g(n);
  return r;
}