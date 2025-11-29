










// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



// Fig. 14

method h1(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n == 1) { return 1; }
  else { return h1(n - 1) + h1 (n - 2); }
}

method h2(n: int) returns (res: int) {
  if (n < 1) { return 0; }
  else if (n == 1) { return 1; }
  else if ((n % 2) == 0) h2(n-1) { var result := + h2(n-2); return result; }
  else { return h2(n-2) + h2(n-2) + h2(n-3); }
}
