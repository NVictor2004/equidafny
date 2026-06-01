import stainless.lang._

object length1 {

  def lengthM[T](l: List[T]): Int = {
      l match {
          case Nil => 0
          case _ :: t => 1 + lengthM(t)
      }
  }
  
  def length1[T](l: List[T]): Int = {
      if l == Nil then 0
      else {
        val _ :: t = l
        1 + length1(t)
      }
  }
}
