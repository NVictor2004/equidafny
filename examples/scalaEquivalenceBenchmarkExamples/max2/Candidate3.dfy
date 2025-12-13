datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(l: List<T>): nat
  decreases(l) {
  match l {
    case Nil        => 0
    case Cons(_, t) => 1 + length(t)
  }
}

function max(l: List<int>): int
  decreases(length(l)) {
  match l
    case Nil => -999999999999 // represent very small number
    case Cons(hd, tl) =>
      match tl {
        case Nil => hd
        case Cons(hd1, tl1) =>
          assert length(Cons(hd, tl1)) < length(l); // Requires additional assertion to prove termination
          if (hd > hd1) then max(Cons(hd, tl1)) else max(Cons(hd1, tl1))
      }
}
