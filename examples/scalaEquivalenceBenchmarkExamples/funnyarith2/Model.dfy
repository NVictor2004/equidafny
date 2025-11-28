
// As funnyarith1 but the Candidate swaps the arguments of sub

  method eval(op: OpKind, x: int, y: int): int = op match {
    case OpKind.Add => add(x, y)
    case OpKind.Sub => sub(x, y)
    case OpKind.Mul => mul(x, y)
  }

  method add(x: int, y: int): int = {
    decreases(if (x <= 0) -x else x)
    if (x == 0) y
    else if (x > 0) add(x - 1, y + 1)
    else add(x + 1, y - 1)
  }

  method sub(x: int, y: int): int = {
    decreases(if (x <= 0) -x else x)
    if (x == 0) -y
    else if (x > 0) sub(x - 1, y - 1)
    else sub(x + 1, y + 1)
  }

  method mul(x: int, y: int): int = {
    decreases(if (x <= 0) -x else x)
    if (x == 0) int(0)
    else if (x > 0) add(mul(x - 1, y), y)
    else sub(mul(x + 1, y), y)
  }
}
