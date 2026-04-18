function andThen1<A, B, C>(f: A -> B, g: B -> C): A -> C
{(a) => g(f(a))}

function andThen2<A, B, C>(ff: A -> B, gg: B -> C): A -> C
{(aa) => gg(ff(aa))}

lemma andThen1_andThen2_Equivalence<A, B, C>(f: A -> B, g: B -> C, a: A)
ensures (andThen1(f, g)(a) == andThen2(f, g)(a))
{{}}

