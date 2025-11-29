












method isEvenTopLvl(x: int) returns (res: bool) isEven(x)

method isOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { var result := !isEven(x - 1); return result; }
}
method isEven(x: int) { var result := returns (res: bool); return result; }
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { var result := !isOdd(x - 1); return result; }
}
