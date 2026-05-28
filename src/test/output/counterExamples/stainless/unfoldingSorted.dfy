datatype Option<T> = None | Some(value: T)

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function unfoldingSortedM<S, T>(start: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, max: int): List<T>
{loopM(start, next, leq, max, Nil)}

function unfoldingSorted4<State, Elem>(start: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, max: int): List<Elem>
{go4(start, next, leq, Nil, max)}

function unfoldingSorted3<State, Elem>(start: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, max: int): List<Elem>
{go3(start, next, Nil, max)}

function insertSorted4<Elem>(t: Elem, leq: (Elem, Elem) -> bool, xs: List<Elem>): List<Elem>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if leq(t, hd) then Cons(t, xs) else Cons(hd, insertSorted4(t, leq, tl))
}
}

function insertM<T>(xs: List<T>, leq: (T, T) -> bool, t: T): List<T>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if leq(t, hd) then Cons(t, xs) else Cons(hd, insertM(tl, leq, t))
}
}

function loopM<S, T>(s: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, fuel: int, xs: List<T>): List<T>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => loopM(nxtS, next, leq, (fuel - 1), insertM(xs, leq, t))
case None => xs
}
}

function go3<State, Elem>(s: State, next: State -> Option<(State, Elem)>, xs: List<Elem>, fuel: int): List<Elem>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => go3(nxtS, next, insertSorted3(t, xs), (fuel - 1))
case None => xs
}
}

function go4<State, Elem>(s: State, next: State -> Option<(State, Elem)>, leq: (Elem, Elem) -> bool, xs: List<Elem>, fuel: int): List<Elem>
decreases (if (fuel <= 0) then 0 else fuel)
{if (fuel <= 0) then xs else match next(s) {
case Some((nxtS, t)) => go4(nxtS, next, leq, insertSorted4(t, leq, xs), (fuel - 1))
case None => match xs {
case Cons(_, _) => go4(s, next, leq, insertSorted4(xs.head, leq, xs), (fuel - 1))
case Nil => xs
}

}
}

function insertSorted3<Elem>(t: Elem, xs: List<Elem>): List<Elem>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => Cons(hd, insertSorted3(t, tl))
}
}

lemma unfoldingSortedM_unfoldingSorted4_Equivalence<S, T>(start: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, max: int)
ensures (unfoldingSortedM(start, next, leq, max) == unfoldingSorted4(start, next, leq, max))
{{loopM_go4_Equivalence(start, next, leq, max, Nil);}}

lemma unfoldingSortedM_unfoldingSorted3_Equivalence<S, T>(start: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, max: int)
ensures (unfoldingSortedM(start, next, leq, max) == unfoldingSorted3(start, next, leq, max))
{{}}

lemma insertM_insertSorted4_Equivalence<T>(xs: List<T>, leq: (T, T) -> bool, t: T)
decreases (xs)
ensures (insertM(xs, leq, t) == insertSorted4(t, leq, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>match leq(t, hd) {
case false =>insertM_insertSorted4_Equivalence(tl, leq, t);
case true =>
}

}
}}

lemma loopM_go4_Equivalence<S, T>(s: S, next: S -> Option<(S, T)>, leq: (T, T) -> bool, fuel: int, xs: List<T>)
decreases (if (fuel <= 0) then 0 else fuel)
ensures (loopM(s, next, leq, fuel, xs) == go4(s, next, leq, xs, fuel))
{{match (fuel <= 0) {
case false =>match next(s) {
case Some((nxtS, t)) =>insertM_insertSorted4_Equivalence(xs, leq, t);loopM_go4_Equivalence(nxtS, next, leq, (fuel - 1), insertM(xs, leq, t));
case None =>
}

case true =>
}
}}

