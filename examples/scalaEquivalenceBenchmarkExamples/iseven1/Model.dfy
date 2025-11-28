

  method isEvenTopLvl(x: int): bool = isEven(x)

  method isOdd(x: int): bool = {
    decreases(if (x <= 0) int(0) else x)
    if (x <= 0) false
    else if (x == 1) true
    else !isEven(x - 1)
  }
  method isEven(x: int): bool = {
    decreases(if (x <= 0) int(0) else x)
    if (x < 0) false
    else if (x == 0) true
    else !isOdd(x - 1)
  }
}
