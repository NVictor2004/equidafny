










// Examples are figures from paper:
// Regression Verification for unbalanced recursive functions
// https://iew.technion.ac.il/~ofers/publications/fm16.pdf



// Fig. 13

function fact13_1(n: int): int {
  if (n <= 1) then 1
  else if (n == 2) then 2
  else if (n == 3) then 6
  else if (n == 4) then 24
  else n * (n-1) * (n-2) * (n-3) * fact13_1(n-4)
}

function fact13_2(n: int): int
  if (n <= 1) then 1
  else if (n == 2) then 2
  else if (n == 3) then 6
  else if (n == 4) then 24
  else if (n == 5) then 120
  else if (n == 6) then 720
  else if (n == 7) then 5040
  else if (n == 8) then 40320
  else n * (n-1) * (n-2) * (n-3) * fact13_2(n-4)
