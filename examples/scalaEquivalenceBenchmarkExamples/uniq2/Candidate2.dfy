datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(lst: List<T>): nat
  decreases(lst) {
  match lst {
    case Nil => 0
    case Cons(_, tl) => 1 + length(tl)
  }
}

function drop(a: int, lst_0: List<int>): List<int>
  decreases(lst_0) {
  match lst_0 {
    case Nil => Nil
    case Cons(hd_0, tl_0) =>
      if (a == hd_0) then drop(a, tl_0) else Cons(hd_0, drop(a, tl_0))
  }
}

// Removed @induct annotation from lst argument
lemma lem(a: int, lst: List<int>)
  ensures length(drop(a, lst)) <= length(lst)
{}

function uniq(lst: List<int>): List<int>
  decreases(length(lst)) {
  match lst {
    case Nil => Nil
    case Cons(hd, tl) =>
      lem(hd, tl);
      assert(length(drop(hd, tl)) <= length(tl));
      assert(length(drop(hd, tl)) < length(lst));
      Cons(hd, uniq(drop(hd, tl)))
  }
}
