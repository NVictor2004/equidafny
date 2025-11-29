












method isEvenTopLvl(x: int) returns (res: bool) !myIsOdd(x) && myIsEven(x) // Note: swapped order to cause "pairs" to be mismatched

method myIsOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { return !myIsEven(x - 1); }
}
method myIsEven(x: int) { var result := returns (res: bool); return result; }
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { return myIsEven(x - 2); }
}
