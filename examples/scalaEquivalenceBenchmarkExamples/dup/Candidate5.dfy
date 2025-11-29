










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function dup<S, T>(n: int, s: S, t: T): List<(S, T)> = {
  decreases(if (n <= 0) int(0) else n) {
  if (n <= 0) { var result := Nil(); return result; }
  else { var result := (s, t) :: dup(n - 1, s, t); return result; }
}
