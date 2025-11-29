










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



function limit2_1(n: int): int {
  if (n <= 0) then n
  else n + limit2_1(n-1)
}

function limit2_2(n: int): int {
  if (n <= 1) then n
  else n + limit2_2(n-1)
}
