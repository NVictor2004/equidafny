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

// CANDIDATE 2
// In Stainless, max2 and maxM are equivalent if you replace -999999999999 with Int.MinValue
// However, Dafny does not have a minimum integer constant, since integers are unbounded here
// Therefore, Dafny cannot prove equivalence of max2 and maxM

function max2(l: List<int>): int
  decreases(l) {
  match l
    case Nil        => -999999999999 // represent very small number
    case Cons(h, t) => if (h > max2(t)) then h else max2(t)
}

// CANDIDATE 4

function max4(l: List<int>): int
  decreases(l) {
  match l {
    case Nil          => 0
    case Cons(hd, tl) => if (hd > max4(tl)) then hd else max4(tl)
  }
}

// CANDIDATE 5

function max5(l: List<int>): int {-1}
