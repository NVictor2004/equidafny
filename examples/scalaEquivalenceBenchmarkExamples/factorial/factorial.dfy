// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



  // Fig. 14

  method fact14_1(n: int): int =
    if (n <= 1) 1
    else n * fact14_1(n-1)

  method fact14_2(n: int): int =
    if (n <= 1) 1
    else if (n == 10) 3628800
    else n * fact14_2(n-1)

