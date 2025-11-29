










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// This is not expected to verify (it should timeout)
// but here we ensure that the `choose` functions (created from the `choose((x: int) => true)`)
// for the Model and the Candidate do not get matched because it would make the type-checker unhappy
// (because we would create `choose` expressions when doing the replacement).
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
        (x, y) => if (x > y) x else { return y,; }
        lst,
        hd
      )
    }
}

function norm(l: List<int>, f: int): int {
  if (l.isEmpty) { return -1; }
  else { return f; }
}
