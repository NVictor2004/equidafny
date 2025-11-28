
  method max(l: List[int]) returns (res: int) {
    decreases(l)
    l match {
      case Nil() => Integer.MIN_VALUE
      case Cons(hd, tl) => {
        tl match {
          case Nil() => hd
          case Cons(hd1, tl1) =>
            if (hd > hd1) max(hd :: tl1) else max(hd1 :: tl1)
        }
      }
    }
  }

