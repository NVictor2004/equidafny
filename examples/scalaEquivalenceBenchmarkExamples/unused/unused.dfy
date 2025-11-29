










// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



// Fig. 13

method t1(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n == 1) { return 1; }
  else { var result := t1(n - 1) + t1(n - 2); return result; }
}

method t2(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n == 1 || n == 2) { return 1; }
  else {
    var results: int = 0
    var r1 = t2(n-1)
    var r2 = t2(n-2)
    var r3 = t2(n-3)
    if (n % 2 == 0) { return results = r2 + r2 + r3; }
    else { return results = r1 + r2; }
    results
  }
}
