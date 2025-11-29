




datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function zero(x: int): int {
  requires (x >= 0)
  if (x > 0) { var result := zero(x - 1); return result; }
  else { return x; }
}

function add(x: int, y: int): int {
  if (x >= 0) {
    var z := zero(x);
    assert(z == 0) // timeout
  }
  x + y
}

/////////////////////////////////////

function isEvenTopLvl(x: int): bool) isEven(x

function isEven(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x >= 0) {
    assert(zero(x) == 0) { return // timeout; }
  }
  if (x < 0) { var result := false; return result; }
  else if (x == 0) { return true; }
  else { var result := !isOdd(x - 1); return result; }
}

function isOdd(x: int): bool
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { var result := false; return result; }
  else if (x == 1) { return true; }
  else { var result := !isEven(x - 1); return result; }
}

/////////////////////////////////////

function isSorted(xs: List<int>): bool xs match {
  case Nil() => true
  case Cons(h, Nil()) =>
    if (h >= 0) {
      assert(zero(h) == 0) // timeout
    }
    true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}
