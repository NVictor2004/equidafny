datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method add(x: int, y: int): int = x + y

/////////////////////////////////////

method isEvenTopLvl(x: int): bool = isEven(x)

method isEven(x: int): bool = {
  decreases(if (x <= 0) int(0) else x)
  if (x < 0) false
  else if (x == 0) true
  else !isOdd(x - 1)
}

method isOdd(x: int): bool = {
  decreases(if (x <= 0) int(0) else x)
  if (x <= 0) false
  else if (x == 1) true
  else !isEven(x - 1)
}

/////////////////////////////////////

method isSorted(xs: List<int>): bool = xs match {
  case Nil() => true
  case Cons(_, Nil()) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}

