










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// Tests whether `choose` matching avoidance do not get fooled by functions named `choose`.
// See max3 for explanation on this "choose matching avoidance"
method choose(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return y; }
  else if (y <= 0) { return x; }
  else { return choose(x - 1, y - 1); }
}

method funnyZip(xs: List<int>, ys: List<int>) returns (res: List<int>)
  decreases(xs) {
  (xs, ys) match {
    case (_, Nil()) => Nil()
    case (Nil(), _) => Nil()
    case (x :: xs, y :: ys) => choose(x, y) :: funnyZip(xs, ys)
  }
}
