datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function unfoldingSorted<State, Elem>(start: State,
                                 next: State => Option[(Elem, State)], // oops, should be State, Elem not Elem, State
                                 leq: (Elem, Elem) => bool,
                                 max: int): List<Elem> = {
  function insertSorted(t: Elem, xs: List<Elem>): List<Elem> = {
    decreases(xs) {
    xs match {
      case Nil() => Cons(t, Nil())
      case Cons(hd, tl) =>
        if (leq(t, hd)) then t :: xs
        else Cons(hd, insertSorted(t, tl))
    }
  }
  function go(s: State, xs: List<Elem>, fuel: int): List<Elem> = {
    decreases(if (fuel <= 0) 0 else fuel) {
    if (fuel <= 0) then xs
    else next(s) match {
      case Some((t, nxtS)) =>
        go(nxtS, insertSorted(t, xs), fuel - 1)
      case None() => xs
    }
  }

  go(start, Nil(), max)
}
