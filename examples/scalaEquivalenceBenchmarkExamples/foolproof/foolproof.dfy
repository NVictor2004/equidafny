// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// Tests whether `choose` matching avoidance do not get fooled by functions named `choose`.
// See max3 for explanation on this "choose matching avoidance"
function choose(x: int, y: int): int
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then y
  else if (y <= 0) then x
  else choose(x - 1, y - 1)
}

function funnyZip(xs: List<int>, ys: List<int>): List<int>
  decreases(xs) {
  match (xs, ys) {
    case (_, Nil) => Nil
    case (Nil, _) => Nil
    case (Cons(x, xs), Cons(y, ys)) => Cons(choose(x, y), funnyZip(xs, ys))
  }
}

// CANDIDATE

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function choose(x: int, y: int): int
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then y
  else if (y <= 0) then x
  else choose(x - 1, y - 1)
}

function funnyZip(xs: List<int>, ys: List<int>): List<int>
  decreases(xs) {
  match (xs, ys) {
    case (_, Nil) => Nil
    case (Nil, _) => Nil
    case (Cons(x, xs), Cons(y, ys)) => Cons(choose(x, y), funnyZip(xs, ys))
  }
}


