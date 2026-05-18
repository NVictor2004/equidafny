datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function f(a: int, b: bool, c: bool): int
function g(x: bool, y: int, z: bool): int

function f2<A>(a: List<A>, b: bool, c: bool): int
function g2<B>(x: bool, y: bool, z: List<B>): int