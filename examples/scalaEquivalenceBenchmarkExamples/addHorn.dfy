










// Examples are figures from paper:
// Automating Regression Verification.
// https://doi.org/10.1145/2642937.2642987



function add_horn_1(i: int, j: int): int
  requires (i >= 0)
{
  if (i == 0) { return j; }
  else { var result := add_horn_1(i-1, j+1); return result; }
}

function add_horn_2(i: int, j: int): int
  requires (i >= 0) {
  if (i == 0) { return j; }
  else if (i == 1) { return j + 1; }
  else { var result := add_horn_2(i-1, j+1); return result; }
}
