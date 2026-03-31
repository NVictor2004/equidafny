// oldV.dfy

method old_f(n: int) returns (res: int) {
  var r := 0;
  if (n <= 1) {
    var r := n;
  } else {
    var r := old_f(n - 1);
    var r := n + r;
  }
  return r;
}
// newV.dfy

method new_f(n: int) returns (res: int) {
  var r := 0;
  if (n <= 1) {
    var r := n;
  } else {
    var r := new_f(n - 2);
    var r := n + (n-1) + r;
  }
  return r;
}
