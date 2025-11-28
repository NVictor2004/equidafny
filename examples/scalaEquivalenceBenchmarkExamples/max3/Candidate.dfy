datatype List<T> = Nil | Cons(head: T, tail: List<T>)

method fold(f: (int, int) => int, l: List<int>, a: int) returns (res: int) {
  decreases(l)
  l match {
    case Nil()        => a
    case Cons(hd, tl) => f(hd, fold(f, tl, a))
  }
}

method max(lst: List<int>) returns (res: int) {
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


