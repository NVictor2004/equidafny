// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// Tests whether `choose` matching avoidance do not get fooled by functions named `choose`.
// See max3 for explanation on this "choose matching avoidance"
function chooseM(x: int, y: int): int
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then y
  else if (y <= 0) then x
  else chooseM(x - 1, y - 1)
}

function funnyZipM(xs: List<int>, ys: List<int>): List<int>
  decreases(xs) {
  match (xs, ys) {
    case (_, Nil) => Nil
    case (Nil, _) => Nil
    case (Cons(x, xs), Cons(y, ys)) => Cons(chooseM(x, y), funnyZipM(xs, ys))
  }
}

// CANDIDATE

function choose1(x: int, y: int): int
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then y
  else if (y <= 0) then x
  else choose1(x - 1, y - 1)
}

function funnyZip1(xs: List<int>, ys: List<int>): List<int>
  decreases(xs) {
  match (xs, ys) {
    case (_, Nil) => Nil
    case (Nil, _) => Nil
    case (Cons(x, xs), Cons(y, ys)) => Cons(choose1(x, y), funnyZip1(xs, ys))
  }
}


