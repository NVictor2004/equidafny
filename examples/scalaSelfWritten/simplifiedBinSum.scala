import stainless.lang._

object simplifiedBinSum {
  // MODEL
  
  def length[T](l: List[T]): Int = {
    l match
      case Nil => 0
      case _ :: t => 1 + length(t)
    }.ensuring(_ >= 0)
  
  // This tests the normalization def where the return type is changed
  
  
  def binSumM(l1: List[Boolean], l2: List[Boolean], c: Boolean): List[Boolean] = {
    decreases(length(l1) + length(l2))
    (l1, l2) match {
      case (Nil, Nil) => Nil
      case (true :: t1, false :: t2) => !c :: binSumM(t1, t2, c)
      case (false :: t1, true :: t2) => !c :: binSumM(t1, t2, c)
      case (false :: t1, false :: t2) => c :: binSumM(t1, t2, false)
      case (true :: t1, true :: t2) => c :: binSumM(t1, t2, true)
      case (true :: t1, Nil) => !c :: binSumM(t1, Nil, c)
      case (false :: t1, Nil) => c :: binSumM(t1, Nil, false)
      case (Nil, true :: t2) => !c :: binSumM(t2, Nil, c)
      case (Nil, false :: t2) => c :: binSumM(t2, Nil, false)
    }
  }
  
  // CANDIDATE
  
  def binSum1(l1: List[Boolean], l2: List[Boolean], c: Boolean): List[Boolean] = {
    decreases(length(l1) + length(l2))
    (l1, l2, c) match
      case (Nil, Nil, _) => Nil
      case (true :: t1, false :: t2, false) => true :: binSum1(t1, t2, false)
      case (true :: t1, false :: t2, true) => false :: binSum1(t1, t2, true)
      case (false :: t1, true :: t2, false) => true :: binSum1(t1, t2, false)
      case (false :: t1, true :: t2, true) => false :: binSum1(t1, t2, true)
      case (false :: t1, false :: t2, false) => false :: binSum1(t1, t2, false)
      case (false :: t1, false :: t2, true) => true :: binSum1(t1, t2, false)
      case (true :: t1, true :: t2, false) => false :: binSum1(t1, t2, true)
      case (true :: t1, true :: t2, true) => true :: binSum1(t1, t2, true)
      case (true :: t1, Nil, true) => false :: binSum1(t1, Nil, true)
      case (true :: t1, Nil, false) => true :: binSum1(t1, Nil, false)
      case (false :: t1, Nil, true) => true :: binSum1 (t1, Nil, false)
      case (false :: t1, Nil, false) => false :: binSum1(t1, Nil, false)
      case (Nil, true :: t1, true) => false :: binSum1(t1, Nil, true)
      case (Nil, true :: t1, false) => true :: binSum1(t1, Nil, false)
      case (Nil, false :: t1, true) => true :: binSum1(t1, Nil, false)
      case (Nil, false :: t1, false) => false :: binSum1(t1, Nil, false)
  }
}
