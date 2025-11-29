











// Testing subfunction matching within subfunctions
// That is, we do not only try to match function appearing in top-level `eval` (mul and myMul)
// but also functions transitively appearing in mul and myMul
// Furthermore, Candidate mySub arguments are swapped
// Top level
function eval(x: int, y: int): int) mul(x, y

function mul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { var result := int(0); return result; }
  else if (x > 0) { var result := add(mul(x - 1, y), y); return result; }
  else { var result := sub(mul(x + 1, y), y); return result; }
}

function add(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return y; }
  else if (x > 0) { var result := add(x - 1, y + 1); return result; }
  else { var result := add(x + 1, y - 1); return result; }
}

function sub(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return -y; }
  else if (x > 0) { var result := sub(x - 1, y - 1); return result; }
  else { var result := sub(x + 1, y + 1); return result; }
}
