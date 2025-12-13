datatype List<T> = Nil | Cons(head: T, tail: List<T>)


// Wrong signature
function dup<S, T>(n: int, t: T, s: S): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup(n - 1, t, s))
}
