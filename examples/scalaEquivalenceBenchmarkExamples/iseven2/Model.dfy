

method isEvenTopLvl(x: int) returns (res: bool) isEven(x) && !isOdd(x) // calls isEven and isOdd to force matching for both of them

method isOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x)
  if (x <= 0) false
  else if (x == 1) true
  else !isEven(x - 1)
}
method isEven(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x)
  if (x < 0) false
  else if (x == 0) true
  else isEven(x - 2)
}

