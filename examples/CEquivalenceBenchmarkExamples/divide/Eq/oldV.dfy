method old_lib(x: int, y: int) returns (res: int) { return x / y; }
method old_client(c: int, d: int) returns (res: int) {
  if (d == 0) {
    return 0;
  }
  return lib(c, d);
}