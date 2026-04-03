datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function maxR(l: seq<int>): int
{if (|l| == 0) then -1 else if (|l| == 1) then l[0] else var m := maxR(l[1 ..]);
if (l[0] > m) then l[0] else m}

function maxT(l: seq<int>): int
{if (|l| == 0) then -1 else foldLeft(bigger, l[0], l[1 ..])}

function maxC(l: seq<int>): int
decreases (|l|)
{if (|l| == 0) then -1 else if (|l| == 1) then l[0] else if (l[0] > l[1]) then maxC(([l[0]] + l[2 ..])) else maxC(l[1 ..])}

function bigger(a: int, b: int): int
{if (a >= b) then a else b}

function foldLeft<A, B>(f: (B, A) -> B, acc: B, l: seq<A>): B
{if (|l| == 0) then acc else foldLeft(f, f(acc, l[0]), l[1 ..])}

function length<A>(l: List<A>): nat
{match l {
case Nil => 0
case Cons(_, tl) => (1 + length(tl))
}
}

lemma maxR_maxT_Equivalence(l: seq<int>)
ensures (maxR(l) == maxT(l))
{{}}

lemma maxR_maxC_Equivalence(l: seq<int>)
ensures (maxR(l) == maxC(l))
{{}}

lemma maxEquivalence2Helper(a: int, b: seq<int>)
ensures (foldLeft(bigger, a, b) == maxR(([a] + b)))
decreases (|b|)
{{}}

