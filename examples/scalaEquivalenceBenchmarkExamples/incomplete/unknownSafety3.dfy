// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function isSortedM(xs: List<int>): bool {
  match xs {
  case Nil => true
  case Cons(_, Nil) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSortedM(t)
}
}

function zero1(x: int): int
  requires (x >= 0) {
  if (x > 0) then zero1(x - 1)
  else x
}

function isSorted1(xs: List<int>): bool {
  match xs {
  case Nil => true
  case Cons(h, Nil) =>
    if (h >= 0) then
      assert(zero1(h) == 0); // timeout
      true
    else
      true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted1(t)
}
}

lemma equivalence_isSorted(xs: List<int>)
  ensures (isSortedM(xs) == isSorted1(xs))
{}
