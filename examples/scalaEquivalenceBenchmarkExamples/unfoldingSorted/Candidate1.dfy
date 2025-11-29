






datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method unfoldingSorted<State, Elem>(start: State,
                                 next: State => Option[(State, Elem)],
                                 leq: (Elem, Elem) => bool,
                                 max: int): List<Elem> = {
  method insertSorted(t: Elem, xs: List<Elem>): List<Elem> = {
    decreases(xs) {
    xs match {
      case Nil() => Cons(t, Nil())
      case Cons(hd, tl) =>
        if (leq(t, hd)) { return t :: xs; }
        else Cons(hd, insertSorted(t, tl))
    }
  }
  method go(s: State, xs: List<Elem>, fuel: int): List<Elem> = {
    decreases(if (fuel <= 0) int(0) else fuel) {
    if (fuel <= 0) { return xs; }
    else next(s) match {
      case Some((nxtS, t)) =>
        go(nxtS, insertSorted(t, xs), fuel - 1)
      case None() => xs
    }
  }

  go(start, Nil(), max)
}
