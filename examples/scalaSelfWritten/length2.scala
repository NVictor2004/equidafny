object length2 {
  datatype List<T> = Nil | Cons(head: T, tail: List<T>)
  
  def lengthTailM<T>(acc: int, l: List<T>): int
      decreases l
  {
      l match {
          case Nil => acc
          case Cons(_, t) => lengthTailM(acc + 1, t)
      }
  }
  
  def lengthTail1<T>(l: List<T>, acc: int): int
      decreases l
  {
      l match {
          case Nil => acc
          case Cons(_, t) => lengthTail1(t, acc + 1)
      }
  }
  
  def lengthM<T>(l: List<T>): int {
      l match {
          case Nil => 0
          case Cons(_, t) => lengthTailM(1, t)
      }
  }
  
  def length1<T>(l: List<T>): int {
      if l == Nil then 0 else lengthTail1(l.tail, 1)
  }
}
