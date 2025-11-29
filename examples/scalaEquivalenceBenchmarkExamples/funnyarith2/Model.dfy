











// As funnyarith1 but the Candidate swaps the arguments of sub

function eval(op: OpKind, x: int, y: int): int op match {
  case OpKind.Add => add(x, y)
  case OpKind.Sub => sub(x, y)
  case OpKind.Mul => mul(x, y)
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

function mul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { var result := int(0); return result; }
  else if (x > 0) { var result := add(mul(x - 1, y), y); return result; }
  else { var result := sub(mul(x + 1, y), y); return result; }
}
