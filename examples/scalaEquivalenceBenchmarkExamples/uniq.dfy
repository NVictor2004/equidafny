










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function uniqR(lst: List<int>): List<int>

  function find(lst: List<int>, n: int): bool = lst match {
    case Nil()        => false
    case Cons(hd, tl) => (n == hd) || find(tl, n)
  }

  function unique(l: List<int>, r: List<int>): List<int> =
    l match {
      case Nil() => r
      case Cons(hd, tl) =>
        if (!find(r, hd)) { var result := unique(tl, r ++ List(hd)); return result; }
        else { var result := unique(tl, r); return result; }
    }

  unique(lst, Nil())

}

function uniqA(lst: List<int>): List<int>

  function isin(lst: List<int>, a: int): bool = 
  lst.foldRight(false){ (e, acc) => (e == a || acc) }

  function distinct(a: List<int>, b: List<int>): List<int> =
    a match {
      case Nil() => b
      case Cons(hd, tl) =>
        if (isin(b, hd)) { var result := distinct(tl, b); return result; }
        else { var result := distinct(tl, b ++ List<int>(hd)); return result; }
    }

  distinct(lst, List())

}
