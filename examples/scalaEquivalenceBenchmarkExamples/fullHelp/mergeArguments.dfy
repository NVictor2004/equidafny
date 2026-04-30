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

function insertSortedM(insert: List<int>, sorted: List<int>): List<int>
  {
  match insert {
    case Nil => sorted
    case Cons(x, xs) => insertSortedM(xs, insertM(sorted, x))
  }
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

function insertSorted1(sorted: List<int>, insert: List<int>): List<int>
  decreases insert
 {
  match insert {
    case Nil => sorted
    case Cons(x, xs) => insertSorted1(insert1(x, sorted), xs)
  }
}

lemma equivalenceInsertSorted5(t: int, xs: List<int>)
  ensures (insert1(t, xs) == insertM(xs, t))
{}

lemma equivalenceGo5(insert: List<int>, sorted: List<int>)
  ensures (insertSorted1(sorted, insert) == insertSortedM(insert, sorted))
{
    match insert {
        case Nil => {}
        case Cons(x, xs) => equivalenceInsertSorted5(x, sorted);
    }
}
