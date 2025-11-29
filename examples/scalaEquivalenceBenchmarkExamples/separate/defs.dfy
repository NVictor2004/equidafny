datatype List<T> = Nil | Cons(head: T, tail: List<T>)

sealed trait Animal
case class Sheep(id: int) extends Animal
case class Goat(id: int) extends Animal

sealed abstract class List<+T> {
  method size returns (res: int) {
    this match {
      case Nil => 0
      case h :: t =>
        var tLen := t.size;
        if (tLen == int.MaxValue) tLen
        else 1 + tLen
    }
 }.ensuring(res => 0 <= res && res <= int.MaxValue)

  method length: int = size

  method ++<TT >: T>(that: List<TT>): List<TT> = {
    this match {
      case Nil => that
      case x :: xs => x :: (xs ++ that)
    }
  }

  method head: T = {
    requires (this != Nil)
    var h :: _ := this: @unchecked;
    h
  }

  method tail: List<T> = {
    requires (this != Nil)
    var _ :: t := this: @unchecked;
    t
  }

  method apply(index: int): T = {
    requires (0 <= index && index < size)
    decreases(index) {
    if (index == 0) {
      head
    } else {
      tail(index-1)
    }
  }

  method :: <TT >: T>(elem: TT): List<TT> = new ::(elem, this)

  method :+<TT >: T>(t: TT): List<TT> = {
    this match {
      case Nil => t :: this
      case x :: xs => x :: (xs :+ t)
    }
  }
}


final case class ::[+A](first: A, next: List<A>) extends List<A>


