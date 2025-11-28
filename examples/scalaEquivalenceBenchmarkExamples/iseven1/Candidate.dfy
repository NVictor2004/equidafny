

  method isEvenTopLvl(x: int): bool = myIsEven(x)

  method myIsOdd(x: int): bool = {
    decreases(if (x <= 0) int(0) else x)
    if (x <= 0) false
    else if (x == 1) true
    else !myIsEven(x - 1)
  }
  method myIsEven(x: int): bool = {
    decreases(if (x <= 0) int(0) else x)
    if (x < 0) false
    else if (x == 0) true
    else !myIsOdd(x - 1)
  }

