










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function unfoldingSorted<State, Elem>(start: State,
                                 next: State => Option[(State, Elem)],
                                 leq: (Elem, Elem) => bool,
                                 max: int): List<Elem> = {
  function insertSorted(t: Elem, xs: List<Elem>): List<Elem> = {
    decreases(xs) {
    xs match {
      case Nil() => Cons(t, Nil())
      case Cons(hd, tl) =>
        if (leq(t, hd)) { return t :: xs; }
        else { var result := Cons(hd, insertSorted(t, tl)); return result; }
    }
  }
  function go(s: State, xs: List<Elem>, fuel: int): List<Elem> = {
    decreases(if (fuel <= 0) int(0) else fuel) {
    if (fuel <= 0) { return xs; }
    else next(s) match {
      case Some((nxtS, t)) =>
        go(nxtS, insertSorted(t, xs), fuel - 1)
      case None() if xs.nonEmpty =>
        // Incorrect, should stop here
        go(s, insertSorted(xs.head, xs), fuel - 1)
      case None() => xs
    }
  }

  go(start, Nil(), max)
}
