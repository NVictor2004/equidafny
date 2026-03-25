method f(n: int) returns (res: int) {
  int r;
  var r := 0;
  if (n <= 1) {
    var r := n;
  } else {
    var r := f(n - 1);
    var r := n + r;
  }
  return r;
}