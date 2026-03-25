method f(x: int) returns (res: int) {
  if (x > 1) {
    var x := f(x-2);
    var x := x + 2;
  }
  if (x < 0) {
    var x := 0;
  }
  return x;
}