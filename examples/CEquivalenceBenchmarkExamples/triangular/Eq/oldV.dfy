method g(n: int) returns (res: int)
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
method triangle(n: int) returns (res: int) {
  int r;
  r = g(n);
  return r;
}