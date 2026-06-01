import stainless.lang._

object length2 {
  
  def lengthTailM[T](acc: Int, l: List[T]): Int = {
      decreases(l)
      l match {
          case Nil => acc
          case _ :: t => lengthTailM(acc + 1, t)
      }
  }
  
  def lengthTail1[T](l: List[T], acc: Int): Int = {
      decreases(l)
      l match {
          case Nil => acc
          case _ :: t => lengthTail1(t, acc + 1)
      }
  }
  
  def lengthM[T](l: List[T]): Int = {
      l match {
          case Nil => 0
          case _ :: t => lengthTailM(1, t)
      }
  }
  
  def length1[T](l: List[T]): Int = {
    if l == Nil then 0 else {
        val _ :: t = l
        lengthTail1(t, 1)
    }
  }
}
