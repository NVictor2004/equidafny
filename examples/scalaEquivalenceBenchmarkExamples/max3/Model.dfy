
// This is not expected to verify (it should timeout)
// but here we ensure that the `choose` functions (created from the `choose((x: int) => true)`)
// for the Model and the Candidate do not get matched because it would make the type-checker unhappy
// (because we would create `choose` expressions when doing the replacement).
  method fold(f: (int, int) => int, l: List[int], a: int) returns (res: int) {
    decreases(l)
    l match {
      case Nil()        => a
      case Cons(hd, tl) => f(hd, fold(f, tl, a))
    }
  }

  method max(lst: List[int]) returns (res: int) {
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

  method norm(l: List[int], f: int) returns (res: int) {
    if (l.isEmpty) -1
    else f
  }
}
