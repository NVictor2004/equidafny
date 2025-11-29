










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function add(x: int, y: int): int x + y

/////////////////////////////////////

function isEvenTopLvl(x: int): bool) isEven(x

function isEven(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x < 0) { return false; }
  else if (x == 0) { return true; }
  else { var result := !isOdd(x - 1); return result; }
}

function isOdd(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return false; }
  else if (x == 1) { return true; }
  else { var result := !isEven(x - 1); return result; }
}

/////////////////////////////////////

function isSorted(xs: List<int>): bool xs match {
  case Nil() => true
  case Cons(_, Nil()) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}
