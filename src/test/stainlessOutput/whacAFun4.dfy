function curry1<A, B, C>(f: (A, B) -> C): A -> B -> C
{(a) => (b) => f(a, b)}

function curry2<A, B, C>(f: (A, B) -> C): A -> B -> C
{(aa) => (bb) => var res := f(aa, bb);
res}

lemma curry1_curry2_Equivalence<A, B, C>(f: (A, B) -> C, a: A, b: B)
ensures (curry1(f)(a)(b) == curry2(f)(a)(b))
{{}}

