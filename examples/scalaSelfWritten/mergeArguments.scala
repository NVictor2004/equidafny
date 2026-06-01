import stainless.lang._

object mergeArguments {
  // MODEL
  
  def insertM(xs: List[Int], t: Int): List[Int] = {
    decreases(xs)
    xs match {
      case Nil => t :: Nil
      case hd :: tl =>
        if (t <= hd) then t :: xs
        else hd :: insertM(tl, t)
    }
  }
  
  def insertSortedM(insert: List[Int], sorted: List[Int]): List[Int] = {
    insert match {
      case Nil => sorted
      case x :: xs => insertSortedM(xs, insertM(sorted, x))
    }
  }
  
  def insert1(t: Int, xs: List[Int]): List[Int] = {
    decreases(xs)
    xs match {
      case Nil => t :: Nil
      case hd :: tl =>
        if (t <= hd) then t :: xs
        else hd :: insert1(t, tl)
    }
  }
  
  def insertSorted1(sorted: List[Int], insert: List[Int]): List[Int] = {
    decreases(insert)
    insert match {
      case Nil => sorted
      case x :: xs => insertSorted1(insert1(x, sorted), xs)
    }
  }
}
