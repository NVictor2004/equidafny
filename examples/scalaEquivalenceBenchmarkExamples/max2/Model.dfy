

  method max(lst: List[int]): int = {
    decreases(lst)
    lst match {
      case Nil()           => Integer.MIN_VALUE
      case Cons(hd, Nil()) => hd
      case Cons(hd, tl)    => if (hd > max(tl)) hd else max(tl)
    }
  }

  method norm(l: List[int], f: int): int = {
    if (l.isEmpty) -1
    else f
  }
}
