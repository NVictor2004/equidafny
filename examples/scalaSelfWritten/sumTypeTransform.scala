import stainless.lang._

object sumTypeTransform {  
  def sumM(l: List[Int]): Int = {
    l match {
      case Nil => 0
      case h :: t => h + sumM(t)
    }
  }
  
  def sum1(data: (List[Int], Int)): Int = {
    decreases(data._1)
    data match {
      case (Nil, acc) => acc
      case (h :: t, acc) => sum1((t, h + acc))
    }
  }
  
  def transform(l: List[Int]): (List[Int], Int) = {
    (l, 0)
  }
}
