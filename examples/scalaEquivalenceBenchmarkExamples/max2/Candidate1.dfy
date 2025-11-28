
  method max(l: List[int]): int = {
    decreases(l)
    l match {
      case Nil()           => 42
      case Cons(hd, Nil()) => hd
      case Cons(hd, tl)    => if (hd > max(tl)) hd else max(tl)
    }
  }
}
