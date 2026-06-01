object max4Simplified {
  // MODEL
  
  datatype List<T> = Nil | Cons(head: T, tail: List<T>)
  
  def maxM(lst: List<int>): int
    decreases(lst) {
    lst match {
      case Nil             => -1
      case Cons(hd, Nil)   => hd
      case Cons(hd, tl)    => if (hd > maxM(tl)) then hd else maxM(tl)
    }
  }
  
  // CANDIDATE 3
  
  def length<T>(l: List<T>): nat
    decreases(l) {
    l match {
      case Nil        => 0
      case Cons(_, t) => 1 + length(t)
    }
  }
  
  def max3(l: List<int>): int
    decreases(length(l)) {
    l match {
      case Nil => -1
      case Cons(hd, tl) =>
        tl match {
          case Nil => hd
          case Cons(hd1, tl1) =>
            assert length(Cons(hd, tl1)) < length(l);
            if (hd > hd1) then max3(Cons(hd, tl1)) else max3(Cons(hd1, tl1))
        }
    }
  }
}
