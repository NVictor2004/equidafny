datatype Animal = Sheep(id :int) | Goat(id :int)
datatype List<T> = Nil | Cons(head :T, tail :List<T>)
function separateM(xs :List<Animal>): (List<Animal>, List<Animal>)
{match xs {
case Nil => (Nil, Nil)
case Cons(Sheep(id), t) => var (s2, g2) := separateM(t);
(Cons(Sheep(id), s2), g2)
case Cons(Goat(id), t) => var (s2, g2) := separateM(t);
(s2, Cons(Goat(id), g2))
}
}function separate2(xs :List<Animal>): (List<Animal>, List<Animal>)
{match xs {
case Nil => (Nil, Nil)
case Cons(Sheep(id), t) => var (s2, g2) := separate2(t);
(Cons(Sheep(id), s2), g2)
case Cons(Goat(id), t) => var (s2, g2) := separate2(t);
(s2, g2)
}
}function separate1(xs :List<Animal>): (List<Animal>, List<Animal>)
{match xs {
case Nil => (Nil, Nil)
case Cons(Sheep(id), t) => var (s2, g2) := separate1(t);
(Cons(Sheep(id), s2), g2)
case Cons(Goat(id), t) => var (s2, g2) := separate1(t);
(s2, Cons(Goat(id), g2))
}
}lemma separate2Equivalence(xs :List<Animal>)
ensures separateM(xs) == separate2(xs)
{{}}lemma separate1Equivalence(xs :List<Animal>)
ensures separateM(xs) == separate1(xs)
{{}}