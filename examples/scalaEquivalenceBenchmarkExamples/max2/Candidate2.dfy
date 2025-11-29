










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int {
  decreases(l) {
  l match {
    case Nil()      => Integer.MIN_VALUE
    case Cons(h, t) => if (h > max(t)) h else max(t)
  }
}
