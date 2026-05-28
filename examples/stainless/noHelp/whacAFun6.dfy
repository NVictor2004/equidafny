// Times out
function rep1<A>(n: int, f: A -> A, a: A): A
  requires (n >= 0) {
  repeat1(n, f)(a)
}

function rep2<A>(n: int, f: A -> A, a: A): A
  requires (n >= 0) {
  repeat2(n, f)(a)
}

function repeat1<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  a =>
    if (n == 0) then a
    else repeat1(n - 1, f)(f(a))
}

function repeat2<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  if (n == 0) then a => a
  else a => repeat2(n - 1, f)(f(a))
}
