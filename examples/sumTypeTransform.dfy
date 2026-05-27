datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function sumM(l: List<int>): int {
  match l {
    case Nil => 0
    case Cons(h, t) => h + sumM(t)
  }
}

function sum1(data: (List<int>, int)): int
  decreases data.0
{
  match data {
    case (Nil, acc) => acc
    case (Cons(h, t), acc) => sum1((t, h + acc))
  }
}

lemma equivalenceHelper(l: List<int>, acc: int)
  ensures acc + sumM(l) == sum1((l, acc))
{
  match l {
    case Nil => {}
    case Cons(h, t) => equivalenceHelper(t, acc + h);
  }
}

lemma equivalence(l: List<int>)
  ensures sumM(l) == sum1(transform(l))
{
  equivalenceHelper(l, 0);
}

function transform(l: List<int>): (List<int>, int) {
  (l, 0)
}