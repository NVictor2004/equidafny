












function isEvenTopLvl(x: int): bool) myIsEven(x

function myIsOdd(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { var result := !myIsEven(x - 1); return result; }
}
function myIsEven(x: int) { var result :=: bool; return result; }
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { var result := !myIsOdd(x - 1); return result; }
}
