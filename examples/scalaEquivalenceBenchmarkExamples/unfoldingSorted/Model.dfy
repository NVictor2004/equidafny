

































datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function unfoldingSorted<S, T>(start: S,
                          next: S => Option[(S, T)],
                          leq: (T, T) => bool,
                          max: int): List<T> = {
  function insert(xs: List<T>, t: T): List<T> = {
    decreases(xs) {
    xs match {
      case Nil() => Cons(t, Nil())
      case Cons(hd, tl) =>
        if (leq(t, hd)) then t :: xs
        else Cons(hd, insert(tl, t))
    }
  }
  function loop(s: S, fuel: int, xs: List<T>): List<T> = {
    decreases(if (fuel <= 0) int(0) else fuel) {
    if (fuel <= 0) then xs
    else next(s) match {
      case Some((nxtS, t)) =>
        loop(nxtS, fuel - 1, insert(xs, t))
      case None() => xs
    }
  }

  loop(start, max, Nil())
}
