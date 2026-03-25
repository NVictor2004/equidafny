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