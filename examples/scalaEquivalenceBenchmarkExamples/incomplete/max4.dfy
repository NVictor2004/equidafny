// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function maxM(lst: List<int>): int
  decreases(lst) {
  match lst {
    case Nil             => -1
    case Cons(hd, Nil)   => hd
    case Cons(hd, tl)    => if (hd > maxM(tl)) then hd else maxM(tl)
  }
}

function norm(l: List<int>, f: int): int {
  match l
    case Nil => -1
    case _   => f
}

// CANDIDATE 3

function length<T>(l: List<T>): nat
  decreases(l) {
  match l {
    case Nil        => 0
    case Cons(_, t) => 1 + length(t)
  }
}

function max3(l: List<int>): int
  decreases(length(l)) {
  match l
    case Nil => -1
    case Cons(hd, tl) =>
      match tl {
        case Nil => hd
        case Cons(hd1, tl1) =>
          assert length(Cons(hd, tl1)) < length(l); // Requires additional assertion to prove termination
          if (hd > hd1) then max3(Cons(hd, tl1)) else max3(Cons(hd1, tl1))
      }
}

lemma equivalenceMax3(l: List<int>)
  ensures (norm(l, max3(l)) == norm(l, maxM(l)))
  decreases(length(l))
{
  match l
    case Cons(hd, Cons(hd1, tl1)) => assert length(Cons(hd, tl1)) < length(l);
    case _ =>
}
