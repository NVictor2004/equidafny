import stainless.lang._

object mapSum {
  
  def sumM(x: Int, y: Int): Int = {
      decreases(if x > 0 then x else -x)
      if x == 0 then y
      else if x < 0 then sumM(x + 1, y - 1)
      else sumM(x - 1, y + 1)
  }
  
  def mapM(l: List[(Int, Int)]): List[Int] = {
      l match {
          case Nil => Nil
          case (h1, h2) :: t => 
              val hM = sumM(h1, h2)
              hM :: mapM(t)
      }
  }
  
  def sum1(x: Int, y: Int): Int = {
      x + y
  }
  
  def map1(l: List[(Int, Int)]): List[Int] = {
      l match {
          case Nil => Nil
          case (h1, h2) :: t => 
              val hC1 = sum1(h1, h2)
              hC1 :: map1(t)
      }
  }
}
