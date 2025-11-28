
  method max(l: List[int]): int = {
    decreases(l)
    l match {
      case Nil()        => 0
      case Cons(hd, tl) => if (hd > max(tl)) hd else max(tl)
    }
  }
}
