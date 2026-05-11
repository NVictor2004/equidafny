// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Animal = Sheep(id: int) | Goat(id: int)

function separateM(xs: List<Animal>): (List<Animal>, List<Animal>) {
  match xs {
    case Nil => (Nil, Nil)
    case Cons(Sheep(id), t) =>
      var (s2, g2) := separateM(t);
      (Cons(Sheep(id), s2), g2)
    case Cons(Goat(id), t) =>
      var (s2, g2) := separateM(t);
      (s2, Cons(Goat(id), g2))
  }
}

// CANDIDATE 2

function separate2(xs: List<Animal>): (List<Animal>, List<Animal>) {
  match xs {
    case Nil => (Nil, Nil)
    case Cons(Sheep(id), t) =>
      var (s2, g2) := separate2(t);
      (Cons(Sheep(id), s2), g2)
    case Cons(Goat(id), t) =>
      var (s2, g2) := separate2(t);
      (s2, g2) // oops, forgets to add goat
  }
}

// Counter Example: xs = Cons(Goat(7), Nil)
lemma equivalenceSeparate2(xs: List<Animal>)
  ensures (separate2(xs) == separateM(xs))
{} 


