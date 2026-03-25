method old_lib(x: int) returns (res: int) {
  if (x == 0)
     return 0;
  if (x < 0)
     return -1;
  else
     return 1;
}
method old_client(x: int) returns (res: int){
  if (x > 0) {
    return lib(x);
  }
  return x;
}