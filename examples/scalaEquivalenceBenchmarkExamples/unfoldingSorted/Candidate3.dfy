datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

// Incorrect, this is an append
function insertSorted<Elem>(t: Elem, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) => Cons(hd, insertSorted(t, tl))
  }
}

function go<State, Elem>(s: State, next: State -> Option<(State, Elem)>, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go(nxtS, next, insertSorted(t, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go(start, next, Nil, max)
}
