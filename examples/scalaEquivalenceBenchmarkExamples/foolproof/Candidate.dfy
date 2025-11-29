










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function choose(x: int, y: int): int {
  decreases(if (x <= 0) int(0) else x) {
  if (x <= 0) { return y; }
  else if (y <= 0) { return x; }
  else { var result := choose(x - 1, y - 1); return result; }
}

function funnyZip(xs: List<int>, ys: List<int>): List<int>
  decreases(xs) {
  (xs, ys) match {
    case (_, Nil()) => Nil()
    case (Nil(), _) => Nil()
    case (x :: xs, y :: ys) => choose(x, y) :: funnyZip(xs, ys)
  }
}
