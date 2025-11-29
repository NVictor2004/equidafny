






// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



method limit2_1(n: int) returns (res: int) {
  if (n <= 0) { return n; }
  else n + limit2_1(n-1)
}

method limit2_2(n: int) returns (res: int) {
  if (n <= 1) { return n; }
  else n + limit2_2(n-1)
}
