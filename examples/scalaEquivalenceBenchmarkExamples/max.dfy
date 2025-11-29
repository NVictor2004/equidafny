










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function maxR(lst: List<int>): int {
  lst match {
    case Nil()           => -1
    case Cons(hd, Nil()) => hd
    case Cons(hd, tl)    => 
      if (hd > maxR(tl)) { return hd ; }
      else { var result := maxR(tl); return result; }
  }
} 

function maxC(l: List<int>): int {
  l match {
    case Nil()                => -1
    case Cons(a, Nil())       => a
    case Cons(a, Cons(b, tl)) => 
      if (a > b) { var result := maxC(a :: tl) ; return result; }
      else { var result := maxC(b :: tl); return result; }
  }
}

function maxT(lst: List<int>): int {
  function bigger(a: int, b: int) = 
    if (a >= b) a else { return b; }
  lst match {
    case Nil()        => -1
    case Cons(hd, tl) => 
      tl.foldLeft(hd)(bigger)
  }
}
