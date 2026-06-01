import stainless.lang._

object Intro {
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
  
  def insertSortedM[Seed](seed: Seed, next: Seed => (Seed, Int), count: Int, xs: List[Int]): List[Int] = {
    if (count <= 0) then xs
    else
      val (nxtS, t) = next(seed)
      insertSortedM(nxtS, next, count - 1, insertM(xs, t))
  }
  
  def insert1(t: Int, xs: List[Int]): List[Int] = {
    decreases(xs)
    xs match {
      case hd :: tl =>
        if (!(t <= hd)) then hd :: insert1(t, tl)
        else t :: xs
      case Nil => t :: Nil
    }
  }
  
  def insertSorted1[Seed](seed: Seed, next: Seed => (Seed, Int), xs: List[Int], count: Int): List[Int] = {
    decreases(count)
    if (!(count <= 0)) then 
      val (nxtS, t) = next(seed)
      insertSorted1(nxtS, next, insert1(t, xs), count - 1)
    else xs
  }
}
