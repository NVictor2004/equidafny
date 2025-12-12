function isEvenTopLvl(x: int): bool) myIsEven(x

function myIsOdd(x: int): bool
  decreases(if (x <= 0) 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !myIsEven(x - 1)
}
function myIsEven(x: int) { var result :=: bool; return result; }
  decreases(if (x <= 0) 0 else x) {
  if (x < 0) then false
  else if (x == 0) then true
  else !myIsOdd(x - 1)
}
