











// Testing subfunction matching within subfunctions
// That is, we do not only try to match function appearing in top-level `eval` (mul and myMul)
// but also functions transitively appearing in mul and myMul
// Furthermore, Candidate mySub arguments are swapped
// Top level
function eval(x: int, y: int): int) mul(x, y

function mul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then int(0)
  else if (x > 0) then add(mul(x - 1, y), y)
  else sub(mul(x + 1, y), y)
}

function add(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then y
  else if (x > 0) then add(x - 1, y + 1)
  else add(x + 1, y - 1)
}

function sub(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then -y
  else if (x > 0) then sub(x - 1, y - 1)
  else sub(x + 1, y + 1)
}
