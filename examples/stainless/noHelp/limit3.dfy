// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



function limit3_1(n: int): int {
  if (n <= 1) then n
  else n + limit3_1(n-1)
}

function limit3_2(n: int): int {
  if (n <= 1) then n
  else
    var r := limit3_2(n-1);
    if (r >= 0) then n + r
    else r
}

lemma equivalenceLimit3_Helper(n: int)
  requires n >= 1
  ensures limit3_2(n) > 0
{}
