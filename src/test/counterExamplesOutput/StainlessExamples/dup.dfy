datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function dupM<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dupM((n - 1), s, t))}

function dup4<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else dup4((n - 1), s, t)}

function dup2<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Cons((s, t), Nil) else Cons((s, t), dup2((n - 1), s, t))}

function norm<S, T>(n: int, s: S, t: T, res: List<(S, T)>): List<(S, T)>
{if (n < 0) then Nil else res}

lemma dupM_dup4_Equivalence<S, T>(n: int, s: S, t: T)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup4(n, s, t)))
{{}}

lemma dupM_dup2_Equivalence<S, T>(n: int, s: S, t: T)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup2(n, s, t)))
{{match (n <= 0) {
case false =>dupM_dup2_Equivalence((n - 1), s, t);
case true =>
}
}}

