function compose1<A, B, C>(f: B -> C, g: A -> B): A -> C
{(a) => f(g(a))}

function compose2<A, B, C>(ff: B -> C, gg: A -> B): A -> C
{(aa) => ff(gg(aa))}

lemma compose1_compose2_Equivalence<A, B, C>(f: B -> C, g: A -> B)
ensures (compose1(f, g) == compose2(f, g))
{{}}

