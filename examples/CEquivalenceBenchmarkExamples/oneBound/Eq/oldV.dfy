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
  if (x > lib(x))
    return x;
  else
    return lib(x);
}