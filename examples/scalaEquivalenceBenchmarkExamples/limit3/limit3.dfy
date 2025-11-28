// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



  method limit3_1(n: int) returns (res: int) {
    if (n <= 1) n
    else n + limit3_1(n-1)
  }

  method limit3_2(n: int) returns (res: int) {
    if (n <= 1) n
    else {
      val r = limit3_2(n-1)
      if (r >= 0) n + r
      else r
    }
  }

