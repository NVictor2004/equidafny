

  method isEvenTopLvl(x: int): bool = !myIsOdd(x) && myIsEven(x) // Note: swapped order to cause "pairs" to be mismatched

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
    else myIsEven(x - 2)
  }
}
