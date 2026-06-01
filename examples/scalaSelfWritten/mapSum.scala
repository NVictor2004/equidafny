object mapSum {
  datatype List<T> = Nil | Cons(head: T, tail: List<T>)
  
  def sumM(x: int, y: int): int
      decreases if x > 0 then x else -x
  {
      if x == 0 then y
      else if x < 0 then sumM(x + 1, y - 1)
      else sumM(x - 1, y + 1)
  }
  
  def mapM(l: List<(int, int)>): List<int> {
      l match {
          case Nil => Nil
          case Cons((h1, h2), t) => 
              var hM := sumM(h1, h2);
              Cons(hM, mapM(t))
      }
  }
  
  def sum1(x: int, y: int): int {
      x + y
  }
  
  def map1(l: List<(int, int)>): List<int> {
      l match {
          case Nil => Nil
          case Cons((h1, h2), t) => 
              var h1 := sum1(h1, h2);
              Cons(h1, map1(t))
      }
  }
}
