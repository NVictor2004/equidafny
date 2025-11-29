

































datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function separate(xs: List<Animal>): (List<Sheep>, List<Goat>) = {
  xs match {
    case Nil => (Nil, Nil)
    case (s: Sheep) :: t =>
      var (s2, g2) := separate(t);
      (s :: s2, g2)
    case (g: Goat) :: t =>
      var (s2, g2) := separate(t);
      (s2, g :: g2)
  }
}
