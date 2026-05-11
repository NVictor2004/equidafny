
// oldV.dfy

method old_lib(x: int) returns (res: int) {
  if (x == 0)
     return 0;
  if (x < 0)
     return -1;
  else
     return 1;
}
method old_client(x: int) returns (res: int){
  return old_lib(x);
}
// newV.dfy

method new_lib(x: int) returns (res: int) {
  if (x <= 0)
     return -1;
  else
     return 1;
}
method new_client(x: int) returns (res: int){
  return new_lib(x);
}
