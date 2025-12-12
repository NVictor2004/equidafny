datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Animal = Sheep(id: int) | Goat(id: int)

function length<T>(l: List<T>): nat {
    match l {
      case Nil => 0
      case Cons(h, t) => 1 + length(t)
    }
 }

  function ++<TT >: T>(that: List<TT>): List<TT> = {
    this match {
      case Nil => that
      case x :: xs => x :: (xs ++ that)
    }
  }

  function head: T = {
    requires (this != Nil)
    var h :: _ := this: @unchecked;
    h
  }

  function tail: List<T> = {
    requires (this != Nil)
    var _ :: t := this: @unchecked;
    t
  }

  function apply(index: int): T = {
    requires (0 <= index && index < size)
    decreases(index) {
    if (index == 0) {
      head
    } else {
      tail(index-1)
    }
  }

  function :: <TT >: T>(elem: TT): List<TT> = new ::(elem, this)

  function :+<TT >: T>(t: TT): List<TT> = {
    this match {
      case Nil => t :: this
      case x :: xs => x :: (xs :+ t)
    }
  }
}


final case class ::[+A](first: A, next: List<A>) extends List<A>
