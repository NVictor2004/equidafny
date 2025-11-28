
// Top level
method eval(op: OpKind, x: int, y: int) returns (res: int) op match {
  case OpKind.Sub => mySub(x, y)
  case OpKind.Mul => myMul(x, y)
  case OpKind.Add => myAdd(x, y)
}

method myAdd(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x)
  if (x == 0) y
  else if (x > 0) myAdd(x - 1, y + 1)
  else myAdd(x + 1, y - 1)
}

method mySub(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x)
  if (x == 0) -y
  else if (x > 0) mySub(x - 1, y - 1)
  else mySub(x + 1, y + 1)
}

method myMul(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x)
  if (x == 0) int(0)
  else if (x > 0) myAdd(myMul(x - 1, y), y)
  else mySub(myMul(x + 1, y), y)
}

