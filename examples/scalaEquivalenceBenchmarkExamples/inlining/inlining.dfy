










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



method inlining_1(x: int) returns (res: int) {
  if (x > 0) inlining_1(x-1) { var result := + int(1); return result; }
  else if (x < 0) { return 0; }
  else { return x; }
}

method inlining_2(x: int) returns (res: int) {
  if (x > 1) inlining_2(x-2) { var result := + int(2); return result; }
  else if (x < 0) { return 0; }
  else { return x; }
}
