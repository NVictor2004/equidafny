










// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



// Fig. 14

method fact14_1(n: int) returns (res: int)
  if (n <= 1) { return 1; }
  else { var result := n * fact14_1(n-1); return result; }

method fact14_2(n: int) returns (res: int)
  if (n <= 1) { return 1; }
  else if (n == 10) { return 3628800; }
  else { var result := n * fact14_2(n-1); return result; }
