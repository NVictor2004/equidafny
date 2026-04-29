// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Option<T> = None | Some(value: T)

function insertM(xs: List<int>, t: int): List<int>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertM(tl, t))
  }
}

function loopM(insert: List<int>, sorted: List<int>): List<int>
  {
  match insert {
    case Cons(x, xs) => loopM(xs, insertM(sorted, x))
    case Nil => sorted
  }
}

function insertSorted5(t: int, xs: List<int>): List<int>
  decreases(xs) {
  match xs {
    case Nil => Cons(t, Nil)
    case Cons(hd, tl) =>
      if (t <= hd) then Cons(t, xs)
      else Cons(hd, insertSorted5(t, tl))
  }
}

function go5(sorted: List<int>, insert: List<int>): List<int>
  decreases insert
 {
  match insert {
    case Cons(x, xs) => go5(insertSorted5(x, sorted), xs)
    case Nil => sorted
  }
}

lemma equivalenceInsertSorted5(t: int, xs: List<int>)
  ensures (insertSorted5(t, xs) == insertM(xs, t))
{}

lemma equivalenceGo5(insert: List<int>, sorted: List<int>)
  ensures (go5(sorted, insert) == loopM(insert, sorted))
{
    match insert {
        case Cons(x, xs) => equivalenceInsertSorted5(x, sorted);
        case Nil => {}
    }
}
