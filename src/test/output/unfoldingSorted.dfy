datatype Option<A> = None | Some(value: A)

datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function unfoldingSortedM<A, B>(start: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, max: int): List<B>
{loopM(start, next, leq, max, Nil)}

function unfoldingSorted5<A, B>(start: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, max: int): List<B>
{go5(start, next, leq, Nil, max)}

function unfoldingSorted1<A, B>(start: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, max: int): List<B>
{go1(start, next, leq, Nil, max)}

function go1<A, B>(s: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, xs: List<B>, fuel: int): List<B>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => go1(nxtS, next, leq, insertSorted1(t, leq, xs), (fuel - 1))
case None => xs
}
}

function insertSorted1<A>(t: A, leq: (A, A) -> bool, xs: List<A>): List<A>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if leq(t, hd) then Cons(t, xs) else Cons(hd, insertSorted1(t, leq, tl))
}
}

function go5<A, B>(s: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, xs: List<B>, fuel: int): List<B>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => go5(nxtS, next, leq, insertSorted5(t, leq, xs), (fuel - 1))
case None => xs
}
}

function insertM<A>(xs: List<A>, leq: (A, A) -> bool, t: A): List<A>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if leq(t, hd) then Cons(t, xs) else Cons(hd, insertM(tl, leq, t))
}
}

function loopM<A, B>(s: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, fuel: int, xs: List<B>): List<B>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => loopM(nxtS, next, leq, (fuel - 1), insertM(xs, leq, t))
case None => xs
}
}

function insertSorted5<A>(t: A, leq: (A, A) -> bool, xs: List<A>): List<A>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if leq(t, hd) then Cons(t, xs) else Cons(hd, insertSorted5(t, leq, tl))
}
}

lemma unfoldingSortedM_unfoldingSorted5_Equivalence<A, B>(start: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, max: int)
ensures (unfoldingSortedM(start, next, leq, max) == unfoldingSorted5(start, next, leq, max))
{{loopM_go5_Equivalence(start, next, leq, max, Nil);}}

lemma unfoldingSortedM_unfoldingSorted1_Equivalence<A, B>(start: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, max: int)
ensures (unfoldingSortedM(start, next, leq, max) == unfoldingSorted1(start, next, leq, max))
{{loopM_go1_Equivalence(start, next, leq, max, Nil);}}

lemma insertM_insertSorted5_Equivalence<A>(xs: List<A>, leq: (A, A) -> bool, t: A)
decreases (xs)
ensures (insertM(xs, leq, t) == insertSorted5(t, leq, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>if leq(t, hd){}else {insertM_insertSorted5_Equivalence(tl, leq, t);}
}
}}

lemma loopM_go5_Equivalence<A, B>(s: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, fuel: int, xs: List<B>)
decreases (if (fuel <= 0) then 0 else fuel)
ensures (loopM(s, next, leq, fuel, xs) == go5(s, next, leq, xs, fuel))
{{if (fuel <= 0){}else {match next(s) {
case Some((nxtS, t)) =>insertM_insertSorted5_Equivalence(xs, leq, t);loopM_go5_Equivalence(nxtS, next, leq, (fuel - 1), insertM(xs, leq, t));
case None =>
}
}}}

lemma insertM_insertSorted1_Equivalence<A>(xs: List<A>, leq: (A, A) -> bool, t: A)
decreases (xs)
ensures (insertM(xs, leq, t) == insertSorted1(t, leq, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>if leq(t, hd){}else {insertM_insertSorted1_Equivalence(tl, leq, t);}
}
}}

lemma loopM_go1_Equivalence<A, B>(s: A, next: A -> Option<(A, B)>, leq: (B, B) -> bool, fuel: int, xs: List<B>)
decreases (if (fuel <= 0) then 0 else fuel)
ensures (loopM(s, next, leq, fuel, xs) == go1(s, next, leq, xs, fuel))
{{if (fuel <= 0){}else {match next(s) {
case Some((nxtS, t)) =>insertM_insertSorted1_Equivalence(xs, leq, t);loopM_go1_Equivalence(nxtS, next, leq, (fuel - 1), insertM(xs, leq, t));
case None =>
}
}}}

