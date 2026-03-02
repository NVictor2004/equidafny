// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



function inlining_1(x: int): int {
  if (x > 0) then inlining_1(x-1) + 1
  else if (x < 0) then 0
  else x
}

function inlining_2(x: int): int {
  if (x > 1) then inlining_2(x-2) + 2
  else if (x < 0) then 0
  else x
}

lemma equivalenceInlining(x: int)
  ensures (inlining_1(x) == inlining_2(x))
{}