










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method maxR(lst: List<int>) returns (res: int) {
  lst match {
    case Nil()           => -1
    case Cons(hd, Nil()) => hd
    case Cons(hd, tl)    => 
      if (hd > maxR(tl)) { return hd ; }
      else { return maxR(tl); }
  }
} 

method maxC(l: List<int>) returns (res: int) {
  l match {
    case Nil()                => -1
    case Cons(a, Nil())       => a
    case Cons(a, Cons(b, tl)) => 
      if (a > b) { var result := maxC(a :: tl) ; return result; }
      else { return maxC(b :: tl); }
  }
}

method maxT(lst: List<int>) returns (res: int) {
  method bigger(a: int, b: int) = 
    if (a >= b) a else { return b; }
  lst match {
    case Nil()        => -1
    case Cons(hd, tl) => 
      tl.foldLeft(hd)(bigger)
  }
}
