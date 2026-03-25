// oldV.dfy

method old_f(n: int) returns (res: int) {
  var r := 0;
  if (n <= 0) {
    var r := n;
  } else {
    var r := f(n - 1);
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
    var r := f(n - 1);
    var r := n + r;
  }
  return r;
}
