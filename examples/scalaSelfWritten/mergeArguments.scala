object mergeArguments {
  // MODEL
  
  datatype List<T> = Nil | Cons(head: T, tail: List<T>)
  
  def insertM(xs: List<int>, t: int): List<int>
    decreases xs {
    xs match {
      case Nil => Cons(t, Nil)
      case Cons(hd, tl) =>
        if (t <= hd) then Cons(t, xs)
        else Cons(hd, insertM(tl, t))
    }
  }
  
  def insertSortedM(insert: List<int>, sorted: List<int>): List<int>
    {
    insert match {
      case Nil => sorted
      case Cons(x, xs) => insertSortedM(xs, insertM(sorted, x))
    }
  }
  
  def insert1(t: int, xs: List<int>): List<int>
    decreases xs {
    xs match {
      case Nil => Cons(t, Nil)
      case Cons(hd, tl) =>
        if (t <= hd) then Cons(t, xs)
        else Cons(hd, insert1(t, tl))
    }
  }
  
  def insertSorted1(sorted: List<int>, insert: List<int>): List<int>
    decreases insert
   {
    insert match {
      case Nil => sorted
      case Cons(x, xs) => insertSorted1(insert1(x, sorted), xs)
    }
  }
}
