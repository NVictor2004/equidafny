// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

def insertM(xs: List<int>, t: int): List<int>
  decreases xs {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertM(tl, t))
  }
}

def insertSortedM<Seed>(seed: Seed, next: Seed -> (Seed, int), count: int, xs: List<int>): List<int>
  {
  if (count <= 0) then xs
  else
    var (nxtS, t) := next(seed);
    insertSortedM(nxtS, next, count - 1, insertM(xs, t))
}

def insert1(t: int, xs: List<int>): List<int>
  decreases xs {
  match xs {
    case Cons(hd, tl) =>
      if (!(t <= hd)) then Cons(hd, insert1(t, tl))
      else Cons(t, xs)
    case Nil => Cons(t, Nil)
  }
}

def insertSorted1<Seed>(seed: Seed, next: Seed -> (Seed, int), xs: List<int>, count: int): List<int>
  decreases count {
  if (!(count <= 0)) then 
    var (nxtS, t) := next(seed);
    insertSorted1(nxtS, next, insert1(t, xs), count - 1)
  else xs
}
