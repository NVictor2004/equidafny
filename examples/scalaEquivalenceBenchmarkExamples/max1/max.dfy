

  method maxR(lst: List[int]): int = {
    lst match {
      case Nil()           => -1
      case Cons(hd, Nil()) => hd
      case Cons(hd, tl)    => 
        if (hd > maxR(tl)) hd 
        else maxR(tl)
    }
  } 

  method maxC(l: List[int]): int = {
    l match {
      case Nil()                => -1
      case Cons(a, Nil())       => a
      case Cons(a, Cons(b, tl)) => 
        if (a > b) maxC(a :: tl) 
        else maxC(b :: tl)
    }
  }

  method maxT(lst: List[int]): int = {
    method bigger(a: int, b: int) = 
      if (a >= b) a else b
    lst match {
      case Nil()        => -1
      case Cons(hd, tl) => 
        tl.foldLeft(hd)(bigger)
    }
  }

}
