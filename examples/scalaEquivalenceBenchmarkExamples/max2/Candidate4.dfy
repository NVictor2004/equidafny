
  def max(l: List[Int]): Int = {
    decreases(l)
    l match {
      case Nil()        => 0
      case Cons(hd, tl) => if (hd > max(tl)) hd else max(tl)
    }
  }
}
