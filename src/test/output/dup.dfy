datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function dupM<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dupM((n - 1), s, t))}

function dup5<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dup5((n - 1), s, t))}

function dup3<S, T>(n: int, t: T, s: S): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dup3((n - 1), t, s))}

function dup1<S, T>(n: int, s: S, t: T): List<(S, T)>
decreases (if (n <= 0) then 0 else n)
{if (n == 0) then Nil else if (n < 0) then Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Nil))))) else Cons((s, t), dup1((n - 1), s, t))}

function norm<S, T>(n: int, s: S, t: T, res: List<(S, T)>): List<(S, T)>
{if (n < 0) then Nil else res}

lemma dupM_dup5_Equivalence<S, T>(n: int, s: S, t: T)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup5(n, s, t)))
{{if (n <= 0){}else {dupM_dup5_Equivalence((n - 1), s, t);}}}

lemma dupM_dup3_Equivalence<S, T>(n: int, s: S, t: T)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup3(n, t, s)))
{{if (n <= 0){}else {dupM_dup3_Equivalence((n - 1), s, t);}}}

lemma dupM_dup1_Equivalence<S, T>(n: int, s: S, t: T)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup1(n, s, t)))
{{}}

