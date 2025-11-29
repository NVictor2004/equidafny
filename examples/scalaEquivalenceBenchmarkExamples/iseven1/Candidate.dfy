












method isEvenTopLvl(x: int) returns (res: bool) myIsEven(x)

method myIsOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { var result := !myIsEven(x - 1); return result; }
}
method myIsEven(x: int) { var result := returns (res: bool); return result; }
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { var result := !myIsOdd(x - 1); return result; }
}
