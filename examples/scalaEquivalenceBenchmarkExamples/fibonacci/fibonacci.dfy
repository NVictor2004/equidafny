










// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



// Fig. 4

method f1(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n <= 2) { return 1; }
  else { var result := f1(n-1) + f1(n-2); return result; }
}

method f2(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n <= 2) { return 1; }
  else { var result := f2(n-2) + f2(n-2) + f2(n-3); return result; }
}
