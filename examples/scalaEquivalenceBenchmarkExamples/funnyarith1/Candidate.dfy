











// Top level
function eval(op: OpKind, x: int, y: int): int op match {
  case OpKind.Sub => mySub(x, y)
  case OpKind.Mul => myMul(x, y)
  case OpKind.Add => myAdd(x, y)
}

function myAdd(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return y; }
  else if (x > 0) { var result := myAdd(x - 1, y + 1); return result; }
  else { var result := myAdd(x + 1, y - 1); return result; }
}

function mySub(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return -y; }
  else if (x > 0) { var result := mySub(x - 1, y - 1); return result; }
  else { var result := mySub(x + 1, y + 1); return result; }
}

function myMul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { var result := int(0); return result; }
  else if (x > 0) { var result := myAdd(myMul(x - 1, y), y); return result; }
  else { var result := mySub(myMul(x + 1, y), y); return result; }
}
