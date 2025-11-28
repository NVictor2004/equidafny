
  method max(l: List[int]) returns (res: int) {
    decreases(l)
    l match {
      case Nil()      => Integer.MIN_VALUE
      case Cons(h, t) => if (h > max(t)) h else max(t)
    }
  }

