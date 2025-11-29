










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function split<T>(l: List<T>, x: T): List<List<T>>
  decreases(l) {
  l match {
    case Nil() => List<List<T>>(List<T>())
    case Cons(y, ys) if x == y =>
      Nil[T]() :: split(ys, x)
    case Cons(y, ys) =>
      var r := split(ys, x);
      (y :: r.head) :: r.tail
  }
}

function join<T>(ll: List<List<T>>, l: List<T>): List<T>
  decreases(ll) {
  ll match {
    case Nil() => Nil[T]()
    case Cons(l1, Nil()) => l1
    case Cons(l1, ls) => l1 ++ l ++ join(ls, l)
  }
}

function replace<T>(l1: List<T>, x: T, l2: List<T>): List<T>
  decreases(l1) {
  l1 match {
    case Nil() => Nil[T]()
    case Cons(y, ys) if x == y => l2 ++ replace(ys, x, l2)
    case Cons(y, ys) => y :: replace(ys, x, l2)
  }
}

function slowReplace<T>(l1: List<T>, x: T, l2: List<T>): List<T>) join(split(l1, x), l2
