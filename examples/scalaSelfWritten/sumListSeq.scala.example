import stainless.lang._

object sumListSeq {  
  def sumAccM(acc: Int, l: Vector[Int]): Int = {
      decreases(l)
      if l.isEmpty then acc
      else sumAccM(acc + l(0), l.tail)
  }
  
  def sumM(l: Vector[Int]): Int = {
      sumAccM(0, l)
  }
  
  def sumAcc1(l: List[Int], acc: Int): Int = {
      decreases(l)
      l match {
          case Nil => acc
          case h :: t => sumAcc1(t, acc + h)
      }
  }
  
  def sum1(l: List[Int]): Int = {
      sumAcc1(l, 0)
  }
  
  def seqToList(l: Vector[Int]): List[Int] = {
      if l.isEmpty then Nil
      else l(0) :: seqToList(l.tail)
  }
}
