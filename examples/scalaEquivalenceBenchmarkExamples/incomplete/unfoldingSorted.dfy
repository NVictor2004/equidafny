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

// CANDIDATE 1

function insertSorted1<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted1(t, leq, tl))
  }
}

function go1<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go1(nxtS, next, leq, insertSorted1(t, leq, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted1<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go1(start, next, leq, Nil, max)
}

lemma equivalenceInsertSorted1<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>)
  ensures (insertSorted1(t, leq, xs) == insertM(xs, leq, t))
{}

lemma equivalenceGo1<State, Elem>(s: State,
                             next: State -> Option<(State, Elem)>,
                             leq: (Elem, Elem) -> bool,
                             xs: List<Elem>,
                             fuel: int)
  ensures (go1(s, next, leq, xs, fuel) == loopM(s, next, leq, fuel, xs))
  decreases(if (fuel <= 0) then 0 else fuel)
{
  if fuel > 0 {
    match next(s) {
      case Some((nxtS, t)) =>
        equivalenceGo1(nxtS, next, leq, insertSorted1(t, leq, xs), fuel - 1);
        equivalenceInsertSorted1(t, leq, xs);
      case None => {}
    }
  }
}

lemma equivalenceUnfoldingSorted1<State, Elem>(start: State,
                                         next: State -> Option<(State, Elem)>,
                                         leq: (Elem, Elem) -> bool,
                                         max: int)
  ensures (unfoldingSorted1(start, next, leq, max) == unfoldingSortedM(start, next, leq, max))
{
  equivalenceGo1(start, next, leq, Nil, max);
}

// CANDIDATE 5

function insertSorted5<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (leq(t, hd)) then Cons(t, xs)
      else Cons(hd, insertSorted5(t, leq, tl))
  }
}

function go5<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
  decreases(if (fuel <= 0) then 0 else fuel) {
  if (fuel <= 0) then xs
  else match next(s) {
    case Some((nxtS, t)) =>
      go5(nxtS, next, leq, insertSorted5(t, leq, xs), fuel - 1)
    case None => xs
  }
}

function unfoldingSorted5<State, Elem>(start: State,
                                 next: State -> Option<(State, Elem)>,
                                 leq: (Elem, Elem) -> bool,
                                 max: int): List<Elem> {

  go5(start, next, leq, Nil, max)
}

lemma equivalenceInsertSorted5<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>)
  ensures (insertSorted5(t, leq, xs) == insertM(xs, leq, t))
{}

lemma equivalenceGo5<State, Elem>(s: State,
                             next: State -> Option<(State, Elem)>,
                             leq: (Elem, Elem) -> bool,
                             xs: List<Elem>,
                             fuel: int)
  ensures (go5(s, next, leq, xs, fuel) == loopM(s, next, leq, fuel, xs))
  decreases(if (fuel <= 0) then 0 else fuel)
{
  if fuel > 0 {
    match next(s) {
      case Some((nxtS, t)) =>
        equivalenceGo5(nxtS, next, leq, insertSorted5(t, leq, xs), fuel - 1);
        equivalenceInsertSorted5(t, leq, xs);
      case None => {}
    }
  }
}

lemma equivalenceUnfoldingSorted5<State, Elem>(start: State,
                                         next: State -> Option<(State, Elem)>,
                                         leq: (Elem, Elem) -> bool,
                                         max: int)
  ensures (unfoldingSorted5(start, next, leq, max) == unfoldingSortedM(start, next, leq, max))
{
  equivalenceGo5(start, next, leq, Nil, max);
}
