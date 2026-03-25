method f(x: int) returns (res: int) {
  if (x > 0) {
    var x := f(x-1);
    var x := x + 1;
  }
  if (x < 0) {
    var x := 0;
  }
  return x;
}