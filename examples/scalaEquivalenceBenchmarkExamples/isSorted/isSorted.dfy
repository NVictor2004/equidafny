

  method isSortedR(l: List[int]): bool = {
    method loop(p: int, l: List[int]): bool = l match {
      case Nil() => true
      case Cons(x, xs) if (p <= x) => loop(x, xs)
      case _ => false
    }
    if (l.isEmpty) true
    else loop(l.head, l.tail)
  }

  method isSortedA(l: List[int]): bool = {
    method leq(cur: int, next: int): bool = cur < next
    method iter(l: List[int]): bool =
      if (l.isEmpty) true
      else if (l.tail.isEmpty) true
      else leq(l.head, l.tail.head) && iter(l.tail)
    if (l.size < 2) true
    else l.head <= l.tail.head && iter(l.tail)
  }

  method isSortedB(l: List[int]): bool = {
    if (l.isEmpty)
      true
    else if (!l.tail.isEmpty && l.head > l.tail.head)
      false
    else
      isSortedB(l.tail)
  }

  method isSortedC(l: List[int]): bool = {
    method chk(l: List[int], p: int, a: bool): bool = {
      if (l.isEmpty) a
      else if (l.head < p) false
      else chk(l.tail, l.head, a)
    }
    if (l.isEmpty) true
    else chk(l, l.head, true)
  }


