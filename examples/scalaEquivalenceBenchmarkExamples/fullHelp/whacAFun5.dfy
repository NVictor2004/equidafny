function uncurry1<A, B, C>(f: A -> B -> C): (A, B) -> C { (a, b) => f(a)(b) }
function uncurry2<A, B, C>(f: A -> B -> C): (A, B) -> C { (a, b) => var res := f(a)(b); res }

lemma equivalenceUncurry<A, B, C>(f: A -> B -> C)
  ensures (uncurry1(f) == uncurry2(f))
{}