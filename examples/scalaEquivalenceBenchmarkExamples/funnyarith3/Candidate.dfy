// Top level
function eval(x: int, y: int): int) myMul(x, y

function myAdd(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then y
  else if (x > 0) then myAdd(x - 1, y + 1)
  else myAdd(x + 1, y - 1)
}

// Computes y - x and not x - y
function mySub(x: int, y: int): int {
  decreases(if (y <= 0) -y else y) {
  if (y == 0) then -x
  else if (y > 0) then mySub(x - 1, y - 1)
  else mySub(x + 1, y + 1)
}

function myMul(x: int, y: int): int {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) then int(0)
  else if (x > 0) then myAdd(myMul(x - 1, y), y)
  else mySub(y, myMul(x + 1, y))
}
