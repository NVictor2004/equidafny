datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function fold(f: (int, int) -> int, l: List<int>, a: int): int
  decreases(l) {
  match l
    case Nil          => a
    case Cons(hd, tl) => f(hd, fold(f, tl, a))
}

function max(lst: List<int>): int {
  match lst
    case Nil => choose((x: int) => true)
    case Cons(hd, tl) =>
      fold(
        (x, y) => if (x > y) then x else y,
        lst,
        hd
      )
    }
