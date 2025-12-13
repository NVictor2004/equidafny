datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l
    case Nil        => -999999999999 // represent very small number
    case Cons(h, t) => if (h > max(t)) then h else max(t)
}
