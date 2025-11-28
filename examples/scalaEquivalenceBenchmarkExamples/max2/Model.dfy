datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method max(lst: List[int]) returns (res: int) {
  decreases(lst)
  lst match {
    case Nil()           => Integer.MIN_VALUE
    case Cons(hd, Nil()) => hd
    case Cons(hd, tl)    => if (hd > max(tl)) hd else max(tl)
  }
}

method norm(l: List[int], f: int) returns (res: int) {
  if (l.isEmpty) -1
  else f
}

