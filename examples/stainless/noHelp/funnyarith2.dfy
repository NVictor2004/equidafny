// MODEL


datatype OpKind = Add | Sub | Mul

// As funnyarith1 but the Candidate swaps the arguments of sub

function evalM(op: OpKind, x: int, y: int): int {match op
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

// CANDIDATE


function eval1(op: OpKind, x: int, y: int): int {
  match op
    case Sub => mySub(y, x)
    case Mul => myMul(x, y)
    case Add => myAdd(x, y)
}

function myAdd(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then y
  else if (x > 0) then myAdd(x - 1, y + 1)
  else myAdd(x + 1, y - 1)
}

// Computes y - x and not x - y
function mySub(x: int, y: int): int
  decreases(if (y <= 0) then -y else y) {
  if (y == 0) then -x
  else if (y > 0) then mySub(x - 1, y - 1)
  else mySub(x + 1, y + 1)
}

function myMul(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then 0
  else if (x > 0) then myAdd(myMul(x - 1, y), y)
  else mySub(y, myMul(x + 1, y))
}
