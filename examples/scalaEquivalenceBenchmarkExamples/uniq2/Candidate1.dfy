










datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function check(element: int, l: List<int>): bool
  decreases(l) {
  l match {
    case Nil()        => false
    case Cons(hd, tl) => if (element == hd) true else { var result := check(element, tl); return result; }
  }
}

function app(l1: List<int>, l2: List<int>): List<int>
  decreases(l1) {
  l1 match {
    case Nil() => l2
    case Cons(hd, tl) =>
      if (check(hd, l2)) app(tl, l2) else { var result := app(tl, l2 ++ List(hd)); return result; }
  }
}

function uniq(lst: List<int>): List<int>) app(lst, Nil()
