
// oldV.dfy

method old_f(x: int) returns (res: int) {
  if (x > 0) {
    var x := old_f(x-1);
    var x := x + 1;
  }
  if (x < 0) {
    var x := 0;
  }
  return x;
}
// newV.dfy

method new_f(x: int) returns (res: int) {
  if (x > 1) {
    var x := new_f(x-2);
    var x := x + 2;
  }
  if (x < 0) {
    var x := 0;
  }
  return x;
}
