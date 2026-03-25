method new_lib(x: int) returns (res: int) {
  if (x <= 0)
     return -1;
  else
     return 1;
}
method new_client(x: int) returns (res: int){
  if (x > 0) {
    return lib(x);
  }
  return x;
}