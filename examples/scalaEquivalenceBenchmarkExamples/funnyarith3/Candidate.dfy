












// Top level
method eval(x: int, y: int) returns (res: int) myMul(x, y)

method myAdd(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { return y; }
  else if (x > 0) { var result := myAdd(x - 1, y + 1); return result; }
  else { var result := myAdd(x + 1, y - 1); return result; }
}

// Computes y - x and not x - y
method mySub(x: int, y: int) returns (res: int) {
  decreases(if (y <= 0) -y else y) {
  if (y == 0) { return -x; }
  else if (y > 0) { var result := mySub(x - 1, y - 1); return result; }
  else { var result := mySub(x + 1, y + 1); return result; }
}

method myMul(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) -x else x) {
  if (x == 0) { var result := int(0); return result; }
  else if (x > 0) { var result := myAdd(myMul(x - 1, y), y); return result; }
  else { var result := mySub(y, myMul(x + 1, y)); return result; }
}
