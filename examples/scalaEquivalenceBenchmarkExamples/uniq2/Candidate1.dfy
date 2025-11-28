datatype List<T> = Nil | Cons(head: T, tail: List<T>)

method check(element: int, l: List<int>) returns (res: bool)
  decreases(l)
  l match {
    case Nil()        => false
    case Cons(hd, tl) => if (element == hd) true else check(element, tl)
  }
}

method app(l1: List<int>, l2: List<int>) returns (res: List<int>)
  decreases(l1)
  l1 match {
    case Nil() => l2
    case Cons(hd, tl) =>
      if (check(hd, l2)) app(tl, l2) else app(tl, l2 ++ List(hd))
  }
}

method uniq(lst: List<int>) returns (res: List<int>) app(lst, Nil())

