datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function dupM<A, B>(n: int, s: A, t: B): List<(A, B)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dupM((n - 1), s, t))}

function dup5<A, B>(n: int, s: A, t: B): List<(A, B)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dup5((n - 1), s, t))}

function dup3<A, B>(n: int, t: B, s: A): List<(A, B)>
decreases (if (n <= 0) then 0 else n)
{if (n <= 0) then Nil else Cons((s, t), dup3((n - 1), t, s))}

function dup1<A, B>(n: int, s: A, t: B): List<(A, B)>
decreases (if (n <= 0) then 0 else n)
{if (n == 0) then Nil else if (n < 0) then Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Nil))))) else Cons((s, t), dup1((n - 1), s, t))}

function norm<A, B>(n: int, s: A, t: B, res: List<(A, B)>): List<(A, B)>
{if (n < 0) then Nil else res}

lemma dupM_dup5_Equivalence<A, B>(n: int, s: A, t: B)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup5(n, s, t)))
{{}}

lemma dupM_dup3_Equivalence<A, B>(n: int, s: A, t: B)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup3(n, t, s)))
{{}}

lemma dupM_dup1_Equivalence<A, B>(n: int, s: A, t: B)
decreases (if (n <= 0) then 0 else n)
ensures (norm(n, s, t, dupM(n, s, t)) == norm(n, s, t, dup1(n, s, t)))
{{}}

