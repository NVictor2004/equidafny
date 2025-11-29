

































datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function fold(f: (int, int) => int, l: List<int>, a: int): int {
  decreases(l) {
  l match {
    case Nil()        => a
    case Cons(hd, tl) => f(hd, fold(f, tl, a))
  }
}

function max(lst: List<int>): int {
  lst match {
    case Nil() => choose((x: int) => true)
    case Cons(hd, tl) =>
      fold(
        (x, y) => if (x > y) x else y,
        lst,
        hd
      )
    }
}
