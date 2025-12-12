datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l {
    case Nil           => 42
    case Cons(hd, Nil) => hd
    case Cons(hd, tl)    => if (hd > max(tl)) then hd else max(tl)
  }
}
