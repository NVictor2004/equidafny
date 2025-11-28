datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method uniqR(lst: List<int>) returns (res: List<int>)

  method find(lst: List<int>, n: int): bool = lst match {
    case Nil()        => false
    case Cons(hd, tl) => (n == hd) || find(tl, n)
  }

  method unique(l: List<int>, r: List<int>): List<int> =
    l match {
      case Nil() => r
      case Cons(hd, tl) =>
        if (!find(r, hd)) unique(tl, r ++ List(hd))
        else unique(tl, r)
    }

  unique(lst, Nil())

}

method uniqA(lst: List<int>) returns (res: List<int>)

  method isin(lst: List<int>, a: int): bool = 
  lst.foldRight(false){ (e, acc) => (e == a || acc) }

  method distinct(a: List<int>, b: List<int>): List<int> =
    a match {
      case Nil() => b
      case Cons(hd, tl) =>
        if (isin(b, hd)) distinct(tl, b)
        else distinct(tl, b ++ List<int>(hd))
    }

  distinct(lst, List())

}


