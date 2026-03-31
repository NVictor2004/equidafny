// oldV.dfy

method old_lib(x: int, y: int) returns (res: int) { return x / y; }
method old_client(c: int, d: int) returns (res: int) {
  if (d == 0) {
    return 0;
  }
  res := old_lib(c, d);
}
// newV.dfy

method new_lib(x: int, y: int) returns (res: int) { return x * y; }
method new_client(c: int, d: int) returns (res: int) {
  if (d == 0) {
    return 0;
  }
  res := new_lib(c, d);
}
