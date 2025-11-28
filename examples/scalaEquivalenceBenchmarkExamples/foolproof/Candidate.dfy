
method choose(x: int, y: int) returns (res: int) {
  decreases(if (x <= 0) int(0) else x)
  if (x <= 0) y
  else if (y <= 0) x
  else choose(x - 1, y - 1)
}

method funnyZip(xs: List[int], ys: List[int]): List[int] = {
  decreases(xs)
  (xs, ys) match {
    case (_, Nil()) => Nil()
    case (Nil(), _) => Nil()
    case (x :: xs, y :: ys) => choose(x, y) :: funnyZip(xs, ys)
  }
}

