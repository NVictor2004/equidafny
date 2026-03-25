// oldV.dfy

method old_f(a: int) returns (res: int) {
  var r := 0;
  if (a > 100) {
    var r := a - 10;
  } else {
    var r := f(a + 11);
    var r := f(r);
  }
  return r;
}
// newV.dfy

method new_f(x: int) returns (res: int) {
  var r := 0;
  if (x < 101) {
    var r := f(11 + x);
    var r := f(r);
  } else {
    var r := x - 10;
  }
  return r;
}