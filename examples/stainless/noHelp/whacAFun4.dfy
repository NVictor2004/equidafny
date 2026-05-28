function curry1<A, B, C>(f: (A, B) -> C): A -> B -> C { a => b => f(a, b) }
function curry2<A, B, C>(f: (A, B) -> C): A -> B -> C { aa => bb => var res := f(aa, bb); res }