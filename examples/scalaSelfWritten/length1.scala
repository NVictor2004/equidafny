object length1 {
  datatype List<T> = Nil | Cons(head: T, tail: List<T>)
  
  def lengthM<T>(l: List<T>): int {
      match l {
          case Nil => 0
          case Cons(_, t) => 1 + lengthM(t)
      }
  }
  
  def length1<T>(l: List<T>): int {
      if l == Nil then 0 else 1 + length1(l.tail)
  }
}
