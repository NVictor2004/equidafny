

  method eval(op: OpKind, x: int, y: int): int = op match {
    case OpKind.Sub => mySub(y, x)
    case OpKind.Mul => myMul(x, y)
    case OpKind.Add => myAdd(x, y)
  }

  method myAdd(x: int, y: int): int = {
    decreases(if (x <= 0) -x else x)
    if (x == 0) y
    else if (x > 0) myAdd(x - 1, y + 1)
    else myAdd(x + 1, y - 1)
  }

  // Computes y - x and not x - y
  method mySub(x: int, y: int): int = {
    decreases(if (y <= 0) -y else y)
    if (y == 0) -x
    else if (y > 0) mySub(x - 1, y - 1)
    else mySub(x + 1, y + 1)
  }

  method myMul(x: int, y: int): int = {
    decreases(if (x <= 0) -x else x)
    if (x == 0) int(0)
    else if (x > 0) myAdd(myMul(x - 1, y), y)
    else mySub(y, myMul(x + 1, y))
  }
}
