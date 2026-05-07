// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function maxM(lst: List<int>): int
  decreases(lst) {
  match lst {
    case Nil             => -999999999999 // represent very small number
    case Cons(hd, Nil)   => hd
    case Cons(hd, tl)    => if (hd > maxM(tl)) then hd else maxM(tl)
  }
}

function norm(l: List<int>, f: int): int {
  match l
    case Nil => -1
    case _   => f
}

// CANDIDATE 1

function max1(l: List<int>): int
  decreases(l) {
  match l {
    case Nil           => 42
    case Cons(hd, Nil) => hd
    case Cons(hd, tl)    => if (hd > max1(tl)) then hd else max1(tl)
  }
}

lemma equivalenceMax1(l: List<int>)
  ensures (norm(l, max1(l)) == norm(l, maxM(l)))
{}