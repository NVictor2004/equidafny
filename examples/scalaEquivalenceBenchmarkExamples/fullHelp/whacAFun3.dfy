function flip1<A, B, C>(f: (A, B) -> C): (B, A) -> C { (b, a) => f(a, b) }
function flip2<A, B, C>(f: (A, B) -> C): (B, A) -> C { (b, a) => var res := f(a, b); res }

// Dafny cannot prove this lemma
lemma equivalenceFlip<A, B, C>(f: (A, B) -> C)
  ensures flip1(f) == flip2(f)
{}