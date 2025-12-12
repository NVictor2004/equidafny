datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function max(lst: List<int>): int
  decreases(lst) {
  match lst {
    case Nil             => -999999999999 // represent very small number
    case Cons(hd, Nil)   => hd
    case Cons(hd, tl)    => if (hd > max(tl)) then hd else max(tl)
  }
}

function norm(l: List<int>, f: int): int {
  match l
    case Nil => -1
    case _   => f
}
