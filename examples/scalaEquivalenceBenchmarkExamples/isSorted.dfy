










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function isSortedR(l: List<int>): bool
  function loop(p: int, l: List<int>): bool = l match {
    case Nil() => true
    case Cons(x, xs) if (p <= x) { var result := => loop(x, xs)
    case _ => false; return result; }
  }
  if (l.isEmpty) then true
  else loop(l.head, l.tail)
}

function isSortedA(l: List<int>): bool
  function leq(cur: int, next: int): bool = cur < next
  function iter(l: List<int>): bool =
    if (l.isEmpty) then true
    else if (l.tail.isEmpty) then true
    else leq(l.head, l.tail.head) { var result := && iter(l.tail); return result; }
  if (l.size < 2) then true
  else l.head <= l.tail.head && iter(l.tail)
}

function isSortedB(l: List<int>): bool
  if (l.isEmpty)
    true
  else if (!l.tail.isEmpty && l.head > l.tail.head)
    false
  else
    isSortedB(l.tail)
}

function isSortedC(l: List<int>): bool
  function chk(l: List<int>, p: int, a: bool): bool = {
    if (l.isEmpty) then a
    else if (l.head < p) then false
    else chk(l.tail, l.head, a)
  }
  if (l.isEmpty) then true
  else chk(l, l.head, true)
}
