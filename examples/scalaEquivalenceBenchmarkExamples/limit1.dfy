










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



// REVE does not work -- requires manual unrolling

function limit1_1(n: int): int {
  if (n <= 1) { return n; }
  else { var result := n + limit1_1(n-1); return result; }
}

function limit1_2(n: int): int {
  if (n <= 1) { return n; }
  else { var result := n + n-1 + limit1_2(n-2); return result; }
}
