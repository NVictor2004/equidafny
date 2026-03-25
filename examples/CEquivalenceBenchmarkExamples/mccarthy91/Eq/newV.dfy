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