










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



method limit3_1(n: int) returns (res: int) {
  if (n <= 1) { return n; }
  else { return n + limit3_1(n-1); }
}

method limit3_2(n: int) returns (res: int) {
  if (n <= 1) { return n; }
  else {
    var r := limit3_2(n-1);
    if (r >= 0) { return n + r; }
    else { return r; }
  }
}
