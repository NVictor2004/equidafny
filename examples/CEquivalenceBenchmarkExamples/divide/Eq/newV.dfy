method new_lib(x: int, y: int) returns (res: int) {
  if (y == 0) {
    return 0;
  }
  return x / y;
}
method new_client(c: int, d: int) returns (res: int) {
  if (d == 0) {
    return 0;
  }
  return lib(c, d);
}