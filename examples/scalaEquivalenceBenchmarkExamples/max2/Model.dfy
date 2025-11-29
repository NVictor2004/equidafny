










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function max(lst: List<int>): int {
  decreases(lst) {
  lst match {
    case Nil()           => Integer.MIN_VALUE
    case Cons(hd, Nil()) => hd
    case Cons(hd, tl)    => if (hd > max(tl)) hd else max(tl)
  }
}

function norm(l: List<int>, f: int): int {
  if (l.isEmpty) then -1
  else f
}
