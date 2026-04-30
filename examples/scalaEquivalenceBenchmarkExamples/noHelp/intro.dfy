// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function insertM(xs: List<int>, t: int): List<int>
  decreases xs {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertM(tl, t))
  }
}

function insertRandomSortedM<Seed>(seed: Seed, next: Seed -> (Seed, int), count: int, xs: List<int>): List<int>
  {
  if (count <= 0) then xs
  else
    var (nxtS, t) := next(seed);
    insertRandomSortedM(nxtS, next, count - 1, insertM(xs, t))
}

function insert1(t: int, xs: List<int>): List<int>
  decreases xs {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insert1(t, tl))
  }
}

function insertRandomSorted1<Seed>(seed: Seed, next: Seed -> (Seed, int), xs: List<int>, count: int): List<int>
  decreases count {
  if (count <= 0) then xs
  else
    var (nxtS, t) := next(seed);
    insertRandomSorted1(nxtS, next, insert1(t, xs), count - 1)
}
