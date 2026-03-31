
// oldV.dfy

method old_lib(x: int) returns (res: int) {
  if (x > 10)
    return 11;
  else
    return x;
}
method old_client(x: int) returns (res: int) {
  if (x < -100 || x > 100) {
    return x;
  }
  if (x > old_lib(x))
    return x;
  else
    return old_lib(x);
}
// newV.dfy

method new_lib(x: int) returns (res: int) {
  if (x > 11)
    return 11;
  else
    return x - 1;
}
method new_client(x: int) returns (res: int) {
  if (x < -100 || x > 100) {
    return x;
  }
  if (x > new_lib(x))
    return x;
  else
    return new_lib(x);
}
