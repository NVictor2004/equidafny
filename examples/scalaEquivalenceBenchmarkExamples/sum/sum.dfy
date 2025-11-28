// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



  // Fig. 5 - two functions are not in lock-step

  method sum1(n: int): int =
    if (n <= 1) n
    else n + n-1 + sum1(n-2)

  method sum2(n: int): int =
    if (n <= 1) n
    else n + sum2(n-1)

