datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function fold(f: (int, int) -> int, l: List<int>, a: int): int
  decreases(l) {
  match l
    case Nil          => a
    case Cons(hd, tl) => f(hd, fold(f, tl, a))
}

// Must be a ghost function since multiple x's can satisfy the such-that assignment
ghost function max(lst: List<int>): int {
  match lst
    case Nil => var x: int :| true; x
    case Cons(hd, tl) =>
      fold(
        (x, y) => if (x > y) then x else y,
        lst,
        hd
      )
    }
