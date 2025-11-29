

































// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



// Fig. 14

function fact14_1(n: int): int
  if (n <= 1) then 1
  else n * fact14_1(n-1)

function fact14_2(n: int): int
  if (n <= 1) then 1
  else if (n == 10) then 3628800
  else n * fact14_2(n-1)
