// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertM<T>(xs: List<T>, leq: (T, T) -> bool, t: T): List<T>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertM(tl, leq, t))
  }
}

function loopM<S, T>(s: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, fuel: int, xs: List<T>): List<T>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      loopM(nxtS, next, leq, fuel - 1, insertM(xs, leq, t))
    case None => xs
  }
}

function unfoldingSortedM<S, T>(start: S,
                          next: S -> Option<(S, T)>,
                          leq: (T, T) -> bool,
                          max: int): List<T> {
  loopM(start, next, leq, max, Nil)
}

// CANDIDATE 3

// Incorrect, this is an append
function insertSorted3<Elem>(t: Elem, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) => Cons(hd, insertSorted3(t, tl))
  }
}

function go3<State, Elem>(s: State, next: State -> Option<(State, Elem)>, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go3(nxtS, next, insertSorted3(t, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted3<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go3(start, next, Nil, max)
}

// CANDIDATE 4

function insertSorted4<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted4(t, leq, tl))
  }
}

function go4<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go4(nxtS, next, leq, insertSorted4(t, leq, xs), fuel - 1)
    case None => match xs
      // Incorrect, should stop here
      case Cons(_, _) => go4(s, next, leq, insertSorted4(xs.head, leq, xs), fuel - 1)
      case Nil => xs
  }
}

function unfoldingSorted4<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go4(start, next, leq, Nil, max)
}
