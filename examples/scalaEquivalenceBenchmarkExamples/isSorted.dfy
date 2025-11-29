










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function isSortedR(l: List<int>): bool
  function loop(p: int, l: List<int>): bool = l match {
    case Nil() => true
    case Cons(x, xs) if (p <= x) { var result := => loop(x, xs)
    case _ => false; return result; }
  }
  if (l.isEmpty) { return true; }
  else { var result := loop(l.head, l.tail); return result; }
}

function isSortedA(l: List<int>): bool
  function leq(cur: int, next: int): bool = cur < next
  function iter(l: List<int>): bool =
    if (l.isEmpty) { return true; }
    else if (l.tail.isEmpty) { return true; }
    else leq(l.head, l.tail.head) { var result := && iter(l.tail); return result; }
  if (l.size < 2) { return true; }
  else { var result := l.head <= l.tail.head && iter(l.tail); return result; }
}

function isSortedB(l: List<int>): bool
  if (l.isEmpty)
    true
  else { var result := if (!l.tail.isEmpty && l.head > l.tail.head); return result; }
    false
  else
    isSortedB(l.tail)
}

function isSortedC(l: List<int>): bool
  function chk(l: List<int>, p: int, a: bool): bool = {
    if (l.isEmpty) { return a; }
    else if (l.head < p) { return false; }
    else { var result := chk(l.tail, l.head, a); return result; }
  }
  if (l.isEmpty) { return true; }
  else { var result := chk(l, l.head, true); return result; }
}
