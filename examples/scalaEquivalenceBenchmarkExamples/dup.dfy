// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup(n - 1, s, t))
}

function norm<S, T>(n: int, s: S, t: T, res: List<(S, T)>): List<(S, T)>
{
  if (n < 0) then Nil else res
}

// CANDIDATE 1

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n == 0) then Nil
  else if (n < 0) then Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Cons((s, t), Nil))))) // Ok because norm will remove this
  else Cons((s, t), dup(n - 1, s, t))
}

// CANDIDATE 2

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Cons((s, t), Nil)
  else Cons((s, t), dup(n - 1, s, t))
}

// CANDIDATE 3

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


// Wrong signature
function dup<S, T>(n: int, t: T, s: S): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup(n - 1, t, s))
}

// CANDIDATE 4

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else dup(n - 1, s, t) // duplicating nils, very useful
}

// CANDIDATE 5

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function dup<S, T>(n: int, s: S, t: T): List<(S, T)>
  decreases(if (n <= 0) then 0 else n) {
  if (n <= 0) then Nil
  else Cons((s, t), dup(n - 1, s, t))
}


