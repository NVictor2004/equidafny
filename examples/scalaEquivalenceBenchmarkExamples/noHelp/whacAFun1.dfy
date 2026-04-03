function andThen1<A, B, C>(f: A -> B, g: B -> C): A -> C { a => g(f(a)) }
function andThen2<A, B, C>(ff: A -> B, gg: B -> C): A -> C { aa => gg(ff(aa)) }