// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dupM<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dupM(n - 1, s, t))
}

function norm<S, T>(n: int, s: S, t: T, res: List<(S, T)>): List<(S, T)>
{
  if (n < 0) then Nil else res
}

// CANDIDATE 1

function dup1<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n == 0) then Nil
  else if (n < 0) then Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Nil))))) // Ok because norm will remove this
  else Cons((s, t), dup1(n - 1, s, t))
}

lemma equivalenceDup1<S, T>(n: int, s: S, t: T)
  ensures (norm(n, s, t, dup1(n, s, t)) == norm(n, s, t, dupM(n, s, t)))
{}

// CANDIDATE 2

function dup2<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Cons((s, t), Nil)
  else Cons((s, t), dup2(n - 1, s, t))
}

// Counter Example: n = 0
lemma equivalenceDup2<S, T>(n: int, s: S, t: T)
  ensures (norm(n, s, t, dup2(n, s, t)) == norm(n, s, t, dupM(n, s, t)))
{}

// CANDIDATE 3

// Wrong signature
function dup3<S, T>(n: int, t: T, s: S): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup3(n - 1, t, s))
}

// Stainless classifies this as wrong since the signatures are different
// However, if you permute the arguments correctly, Dafny is able to prove equivalence
lemma equivalenceDup3<S, T>(n: int, s: S, t: T)
  ensures (norm(n, s, t, dup3(n, t, s)) == norm(n, s, t, dupM(n, s, t)))
{}

// CANDIDATE 4

function dup4<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else dup4(n - 1, s, t) // duplicating nils, very useful
}

// Counter Example: n = 7721
lemma equivalenceDup4<S, T>(n: int, s: S, t: T)
  ensures (norm(n, s, t, dup4(n, s, t)) == norm(n, s, t, dupM(n, s, t)))
{}

// CANDIDATE 5

function dup5<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup5(n - 1, s, t))
}

lemma equivalenceDup5<S, T>(n: int, s: S, t: T)
  ensures (norm(n, s, t, dup5(n, s, t)) == norm(n, s, t, dupM(n, s, t)))
{}
