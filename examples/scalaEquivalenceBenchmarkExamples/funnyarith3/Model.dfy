











// Testing subfunction matching within subfunctions
// That is, we do not only try to match function appearing in top-level `eval` (mul and myMul)
// but also functions transitively appearing in mul and myMul
// Furthermore, Candidate mySub arguments are swapped
// Top level
method eval(x: int, y: int) returns (res: int) mul(x, y)

method mul(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { var result := int(0); return result; }
  else if (x > 0) { var result := add(mul(x - 1, y), y); return result; }
  else { return sub(mul(x + 1, y), y); }
}

method add(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return y; }
  else if (x > 0) { var result := add(x - 1, y + 1); return result; }
  else { return add(x + 1, y - 1); }
}

method sub(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return -y; }
  else if (x > 0) { var result := sub(x - 1, y - 1); return result; }
  else { return sub(x + 1, y + 1); }
}
