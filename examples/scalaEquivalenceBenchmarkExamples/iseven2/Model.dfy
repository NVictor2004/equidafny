












function isEvenTopLvl(x: int): bool) isEven(x) && !isOdd(x // calls isEven and isOdd to force matching for both of them

function isOdd(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { var result := !isEven(x - 1); return result; }
}
function isEven(x: int) { var result :=: bool; return result; }
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { var result := isEven(x - 2); return result; }
}
