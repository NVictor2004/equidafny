// MODEL

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

// CANDIDATE 1

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l {
    case Nil           => 42
    case Cons(hd, Nil) => hd
    case Cons(hd, tl)    => if (hd > max(tl)) then hd else max(tl)
  }
}

// CANDIDATE 2

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l
    case Nil        => -999999999999 // represent very small number
    case Cons(h, t) => if (h > max(t)) then h else max(t)
}

// CANDIDATE 3

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

// CANDIDATE 4

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int
  decreases(l) {
  match l {
    case Nil          => 0
    case Cons(hd, tl) => if (hd > max(tl)) then hd else max(tl)
  }
}

// CANDIDATE 5

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function max(l: List<int>): int {-1}


