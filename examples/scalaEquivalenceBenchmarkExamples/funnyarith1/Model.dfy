











// Testing subfns matching
// In Candidate.eval, the order of patmat over op is not the same here to ensure
// a different starting matching strategy from the correct one: add <-> myAdd; sub <-> mySub; mul <-> myMul
// Top level
function eval(op: OpKind, x: int, y: int): int op match {
  case OpKind.Add => add(x, y)
  case OpKind.Sub => sub(x, y)
  case OpKind.Mul => mul(x, y)
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

function mul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then int(0)
  else if (x > 0) then add(mul(x - 1, y), y)
  else sub(mul(x + 1, y), y)
}
