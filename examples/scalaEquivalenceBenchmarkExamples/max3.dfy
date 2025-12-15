// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// This is not expected to verify (it should timeout)
// but here we ensure that the `choose` functions (created from the `choose((x: int) => true)`)
// for the Model and the Candidate do not get matched because it would make the type-checker unhappy
// (because we would create `choose` expressions when doing the replacement).
function foldM(f: (int, int) -> int, l: List<int>, a: int): int
  decreases(l) {
  match l
    case Nil          => a
    case Cons(hd, tl) => f(hd, foldM(f, tl, a))
  }

ghost function maxM(lst: List<int>): int {
  match lst
    case Nil => var x: int :| true; x
    case Cons(hd, tl) =>
      foldM(
        (x, y) => if (x > y) then x else y,
        lst,
        hd
      )
    }

function norm(l: List<int>, f: int): int {
  match l
    case Nil => -1
    case _   => f
}

// CANDIDATE

function fold1(f: (int, int) -> int, l: List<int>, a: int): int
  decreases(l) {
  match l
    case Nil          => a
    case Cons(hd, tl) => f(hd, fold1(f, tl, a))
}

// Must be a ghost function since multiple x's can satisfy the such-that assignment
ghost function max1(lst: List<int>): int {
  match lst
    case Nil => var x: int :| true; x
    case Cons(hd, tl) =>
      fold1(
        (x, y) => if (x > y) then x else y,
        lst,
        hd
      )
    }


