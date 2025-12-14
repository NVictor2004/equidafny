// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insert<T>(xs: List<T>, leq: (T, T) -> bool, t: T): List<T>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insert(tl, leq, t))
  }
}

function loop<S, T>(s: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, fuel: int, xs: List<T>): List<T>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      loop(nxtS, next, leq, fuel - 1, insert(xs, leq, t))
    case None => xs
  }
}

function unfoldingSorted<S, T>(start: S,
                          next: S -> Option<(S, T)>,
                          leq: (T, T) -> bool,
                          max: int): List<T> {
  loop(start, next, leq, max, Nil)
}

// CANDIDATE 1

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertSorted<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted(t, leq, tl))
  }
}

function go<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go(nxtS, next, leq, insertSorted(t, leq, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go(start, next, leq, Nil, max)
}

// CANDIDATE 2

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertSorted<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted(t, leq, tl))
  }
}

function go<State, Elem>(s: State, next: State -> Option<(Elem, State)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((t, nxtS)) =>
      go(nxtS, next, leq, insertSorted(t, leq, xs), fuel - 1)
    case None() => xs
  }
}

function unfoldingSorted<State, Elem>(start: State,
                                 next: State -> Option<(Elem, State)>, // oops, should be State, Elem not Elem, State
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {
  go(start, next, leq, Nil, max)
}

// CANDIDATE 3

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

// CANDIDATE 4

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertSorted<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted(t, leq, tl))
  }
}

function go<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go(nxtS, next, leq, insertSorted(t, leq, xs), fuel - 1)
    case None => match xs
      // Incorrect, should stop here
      case Cons(_, _) => go(s, next, leq, insertSorted(xs.head, leq, xs), fuel - 1)
      case Nil => xs
  }
}

function unfoldingSorted<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go(start, next, leq, Nil, max)
}

// CANDIDATE 5

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertSorted<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted(t, leq, tl))
  }
}

function go<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go(nxtS, next, leq, insertSorted(t, leq, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go(start, next, leq, Nil, max)
}


