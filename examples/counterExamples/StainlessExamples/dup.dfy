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

// CANDIDATE 2

function dup2<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Cons((s, t), Nil)
  else Cons((s, t), dup2(n - 1, s, t))
}

// CANDIDATE 4

function dup4<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else dup4(n - 1, s, t) // duplicating nils, very useful
}
