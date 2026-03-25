method f(n: int) returns (res: int) {
  int r;
  r = 0;
  if (n <= 0) {
    r = n;
  } else {
    r = f(n - 1);
    r = n + r;
  }
  return r;
}
