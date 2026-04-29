// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function insertM(xs: List<int>, t: int): List<int>
  {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertM(tl, t))
  }
}

function loopM<Seed>(seed: Seed, next: Seed -> (Seed, int), count: int, xs: List<int>): List<int>
  decreases count {
  if (count <= 0) then xs
  else
    var (nxtS, t) := next(seed);
    loopM(nxtS, next, count - 1, insertM(xs, t))
}

function insertSorted5(t: int, xs: List<int>): List<int>
  {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertSorted5(t, tl))
  }
}

function go5<Seed>(seed: Seed, next: Seed -> (Seed, int), xs: List<int>, count: int): List<int>
  decreases count {
  if (count <= 0) then xs
  else
    var (nxtS, t) := next(seed);
    go5(nxtS, next, insertSorted5(t, xs), count - 1)
}

lemma equivalenceInsertSorted5(t: int, xs: List<int>)
  ensures (insertSorted5(t, xs) == insertM(xs, t))
{}

lemma equivalenceGo5<Seed>(seed: Seed,
                             next: Seed -> (Seed, int),
                             xs: List<int>,
                             count: int)
  ensures (go5(seed, next, xs, count) == loopM(seed, next, count, xs))
  decreases count
{
  if count > 0 {
    var (nxtS, t) := next(seed);
    equivalenceGo5(nxtS, next, insertSorted5(t, xs), count - 1);
    equivalenceInsertSorted5(t, xs);
  }
}
