// MODEL


datatype OpKind = Add | Sub | Mul

// Testing subfns matching
// In Candidate.eval, the order of patmat over op is not the same here to ensure
// a different starting matching strategy from the correct one: add <-> myAdd; sub <-> mySub; mul <-> myMul
// Top level
function evalM(op: OpKind, x: int, y: int): int {
  match op
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

// Top level
function eval1(op: OpKind, x: int, y: int): int {
  match op
  case Sub => mySub(x, y)
  case Mul => myMul(x, y)
  case Add => myAdd(x, y)
}

function myAdd(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then y
  else if (x > 0) then myAdd(x - 1, y + 1)
  else myAdd(x + 1, y - 1)
}

function mySub(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then -y
  else if (x > 0) then mySub(x - 1, y - 1)
  else mySub(x + 1, y + 1)
}

function myMul(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then 0
  else if (x > 0) then myAdd(myMul(x - 1, y), y)
  else mySub(myMul(x + 1, y), y)
}

lemma equivalenceAdd(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (add(x, y) == myAdd(x, y))
{}

lemma equivalenceSub(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (sub(x, y) == mySub(x, y))
{}

lemma equivalenceMul(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (mul(x, y) == myMul(x, y))
{
  equivalenceAdd(mul(x - 1, y), y);
  equivalenceSub(mul(x + 1, y), y);
}

lemma equivalenceEval(op: OpKind, x: int, y: int)
  ensures (eval1(op, x, y) == evalM(op, x, y))
{
  equivalenceAdd(x, y);
  equivalenceSub(x, y);
  equivalenceMul(x, y);
}

