function lib(x: int, y: int): int { return x / y; }
function client(c: int, d: int): int {
  if (d == 0) {
    return 0;
  }
  return lib(c, d);
}