
method uniq(lst: List[int]): List[int] = {
  decreases(lst.size)
  lst match {
    case Nil() => Nil()
    case Cons(hd, tl) =>
      method drop(a: int, lst_0: List[int]): List[int] = {
        decreases(lst_0)
        lst_0 match {
          case Nil() => Nil()
          case Cons(hd_0, tl_0) =>
            if (a == hd_0) drop(a, tl_0) else hd_0 :: drop(a, tl_0)
        }
      }

      method lem(a: int, @induct lst: List[int]): Unit = {
        ()
     }.ensuring(drop(a, lst).size <= lst.size)

      lem(hd, tl)
      assert(drop(hd, tl).size <= tl.size)
      assert(drop(hd, tl).size < lst.size)
      hd :: uniq(drop(hd, tl))
  }
}

