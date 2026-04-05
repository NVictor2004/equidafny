function flip1<A, B, C>(f: (A, B) -> C): (B, A) -> C
{(b, a) => f(a, b)}

function flip2<A, B, C>(f: (A, B) -> C): (B, A) -> C
{(b, a) => var res := f(a, b);
res}

lemma flip1_flip2_Equivalence<A, B, C>(f: (A, B) -> C)
ensures (flip1(f) == flip2(f))
{{}}

