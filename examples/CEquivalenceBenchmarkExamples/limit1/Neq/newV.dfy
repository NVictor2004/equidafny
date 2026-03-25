method f(n: int) returns (res: int) {
  var r := 0;
  if (n <= 1) {
    var r := n;
  } else {
    var r := f(n - 3);
    var r := n + (n-1) + r;
  }
  return r;
}