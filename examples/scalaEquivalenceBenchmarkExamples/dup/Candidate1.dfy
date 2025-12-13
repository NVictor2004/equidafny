datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n == 0) then Nil
  else if (n < 0) then Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Nil))))) // Ok because norm will remove this
  else Cons((s, t), dup(n - 1, s, t))
}
