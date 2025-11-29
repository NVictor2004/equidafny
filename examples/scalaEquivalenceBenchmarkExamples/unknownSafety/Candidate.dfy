




datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method zero(x: int) returns (res: int) {
  requires (x >= 0)
  if (x > 0) { var result := zero(x - 1); return result; }
  else { return x; }
}

method add(x: int, y: int) returns (res: int) {
  if (x >= 0) {
    var z := zero(x);
    assert(z == 0) // timeout
  }
  x + y
}

/////////////////////////////////////

method isEvenTopLvl(x: int) returns (res: bool) isEven(x)

method isEven(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x >= 0) {
    assert(zero(x) == 0) { return // timeout; }
  }
  if (x < 0) { var result := false; return result; }
  else if (x == 0) { return true; }
  else { return !isOdd(x - 1); }
}

method isOdd(x: int) returns (res: bool)
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { var result := false; return result; }
  else if (x == 1) { return true; }
  else { return !isEven(x - 1); }
}

/////////////////////////////////////

method isSorted(xs: List<int>) returns (res: bool) xs match {
  case Nil() => true
  case Cons(h, Nil()) =>
    if (h >= 0) {
      assert(zero(h) == 0) // timeout
    }
    true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted(t)
}
