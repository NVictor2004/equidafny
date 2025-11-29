










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



function limit3_1(n: int): int {
  if (n <= 1) { return n; }
  else { var result := n + limit3_1(n-1); return result; }
}

function limit3_2(n: int): int {
  if (n <= 1) { return n; }
  else {
    var r := limit3_2(n-1);
    if (r >= 0) { return n + r; }
    else { return r; }
  }
}
