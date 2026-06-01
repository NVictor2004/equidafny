import stainless.lang._

object max4Simplified {
  // MODEL

  def maxM(lst: List[Int]): Int = {
    decreases(lst)
    lst match {
      case Nil             => -1
      case hd :: Nil   => hd
      case hd :: tl    => if (hd > maxM(tl)) then hd else maxM(tl)
    }
  }
  
  // CANDIDATE 3
  
  def length[T](l: List[T]): Int = {
    decreases(l)
    l match {
      case Nil        => 0
      case _ :: t => 1 + length(t)
    }
  }.ensuring(_ >= 0)
  
  def max3(l: List[Int]): Int = {
    decreases(length(l))
    l match {
      case Nil => -1
      case hd :: tl =>
        tl match {
          case Nil => hd
          case hd1 :: tl1 =>
            assert(length(hd :: tl1) < length(l))
            if (hd > hd1) then max3(hd :: tl1) else max3(hd1 :: tl1)
        }
    }
  }
}
