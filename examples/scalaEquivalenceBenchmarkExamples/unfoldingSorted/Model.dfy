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
