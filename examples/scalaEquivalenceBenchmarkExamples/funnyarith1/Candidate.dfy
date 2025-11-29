











// Top level
function eval(op: OpKind, x: int, y: int): int op match {
  case OpKind.Sub => mySub(x, y)
  case OpKind.Mul => myMul(x, y)
  case OpKind.Add => myAdd(x, y)
}

function myAdd(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then y
  else if (x > 0) then myAdd(x - 1, y + 1)
  else myAdd(x + 1, y - 1)
}

function mySub(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then -y
  else if (x > 0) then mySub(x - 1, y - 1)
  else mySub(x + 1, y + 1)
}

function myMul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then int(0)
  else if (x > 0) then myAdd(myMul(x - 1, y), y)
  else mySub(myMul(x + 1, y), y)
}
