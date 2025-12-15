// MODEL

// Testing subfunction matching within subfunctions
// That is, we do not only try to match function appearing in top-level `eval` (mul and myMul)
// but also functions transitively appearing in mul and myMul
// Furthermore, Candidate mySub arguments are swapped
// Top level
function evalM(x: int, y: int): int {mul(x, y)}

function mul(x: int, y: int): int
  decreases(if (x <= 0) then -x else x) {
  if (x == 0) then 0
  else if (x > 0) then add(mul(x - 1, y), y)
  else sub(mul(x + 1, y), y)
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

// CANDIDATE

// Top level
function eval1(x: int, y: int): int { myMul(x, y) }

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

lemma equivalenceAdd(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (add(x, y) == myAdd(x, y))
{}

lemma equivalenceSub(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (sub(x, y) == mySub(y, x))
{}

lemma equivalenceMul(x: int, y: int)
  decreases(if (x <= 0) then -x else x)
  ensures (mul(x, y) == myMul(x, y))
{
  equivalenceAdd(mul(x - 1, y), y);
  equivalenceSub(mul(x + 1, y), y);
}

lemma equivalenceEval(x: int, y: int)
  ensures (eval1(x, y) == evalM(x, y))
{
  equivalenceMul(x, y);
}
