datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function snoc<T>(l: List<T>, elem: T): List<T> {
  match l {
    case Nil => Cons(elem, Nil)
    case Cons(hd, tl) => Cons(hd, snoc(tl, elem))
  }
}

function check(element: int, l: List<int>): bool
  decreases(l) {
  match l {
    case Nil        => false
    case Cons(hd, tl) => if (element == hd) then true else check(element, tl)
  }
}

function app(l1: List<int>, l2: List<int>): List<int>
  decreases(l1) {
  match l1 {
    case Nil => l2
    case Cons(hd, tl) =>
      if (check(hd, l2)) then app(tl, l2) else app(tl, snoc(l2, hd))
  }
}

function uniq(lst: List<int>): List<int> {app(lst, Nil())}
