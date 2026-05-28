// Comparing solution_3 and uniq1

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// MODEL

function snoc<T>(l: List<T>, elem: T): List<T> {
  match l {
    case Nil => Cons(elem, Nil)
    case Cons(hd, tl) => Cons(hd, snoc(tl, elem))
  }
}

function is_in_3(lst: List<int>, a: int): bool
  decreases(lst) {
  match lst {
    case Nil        => false
    case Cons(hd, tl) => if (a == hd) then true else is_in_3(tl, a)
  }
}

function unique_3(lst1: List<int>, lst2: List<int>): List<int>
  decreases(lst1) {
  match lst1 {
    case Nil => lst2
    case Cons(hd, tl) =>
      if (is_in_3(lst2, hd)) then unique_3(tl, lst2) else unique_3(tl, snoc(lst2, hd))
  }
}

function solution_3(lst: List<int>): List<int> { unique_3(lst, Nil) }

// CANDIDATE 1

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

function uniq1(lst: List<int>): List<int> {app(lst, Nil())}