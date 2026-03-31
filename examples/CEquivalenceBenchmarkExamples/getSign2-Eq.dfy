
// oldV.dfy

method old_lib(x: int) returns (res: int) {
  if (x == 0) {
     return 0;
  }
  if (x < 0) {
     return -1;
  }
  else {
     return 1;
  }
}
method old_client(x: int) returns (res: int){
  if (x > 0) {
    res := old_lib(x);
  }
  return x;
}
// newV.dfy

method new_lib(x: int) returns (res: int) {
  if (x <= 0) {
     return -1;
  }
  else {
     return 1;
  }
}
method new_client(x: int) returns (res: int){
  if (x > 0) {
    res := new_lib(x);
  }
  return x;
}
