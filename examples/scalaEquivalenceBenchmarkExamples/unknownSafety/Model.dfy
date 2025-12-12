datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function add(x: int, y: int): int x + y

/////////////////////////////////////

function isEvenTopLvl(x: int): bool) isEven(x

function isEven(x: int): bool
  decreases(if (x <= 0) 0 else x) {
  if (x < 0) then false
  else if (x == 0) then true
  else !isOdd(x - 1)
}

function isOdd(x: int): bool
  decreases(if (x <= 0) 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !isEven(x - 1)
}

/////////////////////////////////////

function isSorted(xs: List<int>): bool xs match {
  case Nil() => true
  case Cons(_, Nil()) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}
