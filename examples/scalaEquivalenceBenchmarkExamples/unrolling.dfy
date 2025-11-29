










// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



// Fig. 13

method fact13_1(n: int) returns (res: int)
  if (n <= 1) { return 1; }
  else if (n == 2) { return 2; }
  else if (n == 3) { return 6; }
  else if (n == 4) { return 24; }
  else { var result := n * (n-1) * (n-2) * (n-3) * fact13_1(n-4); return result; }

method fact13_2(n: int) returns (res: int)
  if (n <= 1) { var result := 1; return result; }
  else if (n == 2) { return 2; }
  else if (n == 3) { return 6; }
  else if (n == 4) { return 24; }
  else if (n == 5) { return 120; }
  else if (n == 6) { return 720; }
  else if (n == 7) { return 5040; }
  else if (n == 8) { return 40320; }
  else { var result := n * (n-1) * (n-2) * (n-3) * fact13_2(n-4); return result; }
