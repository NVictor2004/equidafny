method lib(x: int, y: int) returns (res: int) { return x / y; }
method client(c: int, d: int) returns (res: int) {
  if (d == 0) {
    return 0;
  }
  return lib(c, d);
}