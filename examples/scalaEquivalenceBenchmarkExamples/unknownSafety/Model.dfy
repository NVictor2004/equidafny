






datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method add(x: int, y: int) returns (res: int) x + y

/////////////////////////////////////

method isEvenTopLvl(x: int) returns (res: bool) isEven(x)

method isEven(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else !isOdd(x - 1)
}

method isOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else !isEven(x - 1)
}

/////////////////////////////////////

method isSorted(xs: List<int>) returns (res: bool) xs match {
  case Nil() => true
  case Cons(_, Nil()) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}
