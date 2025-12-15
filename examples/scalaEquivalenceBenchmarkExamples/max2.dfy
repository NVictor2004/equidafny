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

// CANDIDATE 2

function max2(l: List<int>): int
  decreases(l) {
  match l
    case Nil        => -999999999999 // represent very small number
    case Cons(h, t) => if (h > max2(t)) then h else max2(t)
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
    case Nil => -999999999999 // represent very small number
    case Cons(hd, tl) =>
      match tl {
        case Nil => hd
        case Cons(hd1, tl1) =>
          assert length(Cons(hd, tl1)) < length(l); // Requires additional assertion to prove termination
          if (hd > hd1) then max3(Cons(hd, tl1)) else max3(Cons(hd1, tl1))
      }
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


