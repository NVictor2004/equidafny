datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l {
    case Nil          => 0
    case Cons(hd, tl) => if (hd > max(tl)) then hd else max(tl)
  }
}
