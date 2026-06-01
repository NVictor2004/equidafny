datatype List<T> = Nil | Cons(head: T, tail: List<T>)

def sumM(l: List<int>): int {
  match l {
    case Nil => 0
    case Cons(h, t) => h + sumM(t)
  }
}

def sum1(data: (List<int>, int)): int
  decreases data.0
{
  match data {
    case (Nil, acc) => acc
    case (Cons(h, t), acc) => sum1((t, h + acc))
  }
}

def transform(l: List<int>): (List<int>, int) {
  (l, 0)
}