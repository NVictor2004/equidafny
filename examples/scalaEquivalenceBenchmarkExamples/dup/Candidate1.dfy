









datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)> = {
  decreases(if (n <= 0) int(0) else n) {
  if (n == 0) { var result := Nil(); return result; }
  else if (n < 0) List((s, t), (s, t), (s, t), (s, t), (s, t)) { return // Ok because norm will remove this; }
  else { var result := (s, t) :: dup(n - 1, s, t); return result; }
}
