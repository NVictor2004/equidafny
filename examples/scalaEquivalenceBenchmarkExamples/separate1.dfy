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

// CANDIDATE 1

function separate1(xs: List<Animal>): (List<Animal>, List<Animal>) {
  match xs
    case Nil => (Nil, Nil)
    case Cons(Sheep(id), t) =>
      var (s2, g2) := separate1(t);
      (Cons(Sheep(id), s2), g2)
    case Cons(Goat(id), t) =>
      var (s2, g2) := separate1(t);
      (s2, Cons(Goat(id), g2))
  }

lemma equivalenceSeparate1(xs: List<Animal>)
  ensures (separate1(xs) == separateM(xs))
{}

