
datatype OpKind = Add | Sub | Mul

// As funnyarith1 but the Candidate swaps the arguments of sub

function eval(op: OpKind, x: int, y: int): int {match op
  case Add => add(x, y)
  case Sub => sub(x, y)
  case Mul => mul(x, y)
}

function add(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then y
  else if (x > 0) then add(x - 1, y + 1)
  else add(x + 1, y - 1)
}

function sub(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then -y
  else if (x > 0) then sub(x - 1, y - 1)
  else sub(x + 1, y + 1)
}

function mul(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then 0
  else if (x > 0) then add(mul(x - 1, y), y)
  else sub(mul(x + 1, y), y)
}
