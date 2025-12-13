datatype List<T> = Nil | Cons(head: T, tail: List<T>)

datatype Animal = Sheep(id: int) | Goat(id: int)

function separate(xs: List<Animal>): (List<Animal>, List<Animal>) {
  match xs {
    case Nil => (Nil, Nil)
    case Cons(Sheep(id), t) =>
      var (s2, g2) := separate(t);
      (Cons(Sheep(id), s2), g2)
    case Cons(Goat(id), t) =>
      var (s2, g2) := separate(t);
      (s2, Cons(Goat(id), g2))
  }
}
