// Examples are figures from paper:
// Regression verification of unbalanced recursive functions with multiple calls (long version)
// https://arxiv.org/pdf/2207.14364.pdf



  // Fig. 12

  method m1(n: int, flag: bool) returns (res: int) {
    if (n < 1) 0
    else if (n == 1) 1
    else m1(n - 1, !flag) + m1(n - 2, !flag)
  }

  method m2(n: int, mode: bool) returns (res: int) {
    if (n < 1) 0
    else if (n == 1 || n == 2) 1
    else {
      var results: int = 0
      if (mode) results = m2(n-2, !mode) + m2(n-2, !mode) + m2(n-3, !mode)
      if (!mode) results = m2(n-1, !mode) + m2(n-2, !mode)
      results
    }
  }

}
