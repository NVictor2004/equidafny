// oldV.dfy

method old_f(a: int) returns (res: int) {
  var r := 0;
  if (a > 100) {
    var r := a - 10;
  } else {
    var r := old_f(a + 11);
    var r := old_f(r);
  }
  return r;
}
// newV.dfy

method new_f(x: int) returns (res: int) {
  var r := 0;
  if (x < 101) {
    var r := new_f(11 + x);
    var r := new_f(r);
  } else {
    var r := x - 10;
  }
  return r;
}
