






// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



// REVE does not work -- requires manual unrolling

method limit1_1(n: int) returns (res: int) {
  if (n <= 1) { return n; }
  else n + limit1_1(n-1)
}

method limit1_2(n: int) returns (res: int) {
  if (n <= 1) { return n; }
  else n + n-1 + limit1_2(n-2)
}
