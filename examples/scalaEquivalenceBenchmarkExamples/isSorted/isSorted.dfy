










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


method isSortedR(l: List<int>) returns (res: bool)
  method loop(p: int, l: List<int>): bool = l match {
    case Nil() => true
    case Cons(x, xs) if (p <= x) { var result := => loop(x, xs)
    case _ => false; return result; }
  }
  if (l.isEmpty) { return true; }
  else { return loop(l.head, l.tail); }
}

method isSortedA(l: List<int>) returns (res: bool)
  method leq(cur: int, next: int): bool = cur < next
  method iter(l: List<int>): bool =
    if (l.isEmpty) { return true; }
    else if (l.tail.isEmpty) { return true; }
    else leq(l.head, l.tail.head) { var result := && iter(l.tail); return result; }
  if (l.size < 2) { return true; }
  else { return l.head <= l.tail.head && iter(l.tail); }
}

method isSortedB(l: List<int>) returns (res: bool)
  if (l.isEmpty)
    true
  else { return if (!l.tail.isEmpty && l.head > l.tail.head); }
    false
  else
    isSortedB(l.tail)
}

method isSortedC(l: List<int>) returns (res: bool)
  method chk(l: List<int>, p: int, a: bool): bool = {
    if (l.isEmpty) { return a; }
    else if (l.head < p) { return false; }
    else { return chk(l.tail, l.head, a); }
  }
  if (l.isEmpty) { return true; }
  else { return chk(l, l.head, true); }
}
