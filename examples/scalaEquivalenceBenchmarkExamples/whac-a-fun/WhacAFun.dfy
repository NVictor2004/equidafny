
method andThen1[A, B, C](f: A => B, g: B => C): A => C = a => g(f(a))
method andThen2[A, B, C](ff: A => B, gg: B => C): A => C = aa => gg(ff(aa))

method compose1[A, B, C](f: B => C, g: A => B): A => C = a => f(g(a))
method compose2[A, B, C](ff: B => C, gg: A => B): A => C = aa => ff(gg(aa))

method flip1[A, B, C](f: (A, B) => C): (B, A) => C = (b, a) => f(a, b)
method flip2[A, B, C](f: (A, B) => C): (B, A) => C = (b, a) => {var res := f(a, b); res };

method curry1[A, B, C](f: (A, B) => C): A => B => C = a => b => f(a, b)
method curry2[A, B, C](f: (A, B) => C): A => B => C = aa => bb => { var res := f(aa, bb); res };

method uncurry1[A, B, C](f: A => B => C): (A, B) => C = (a, b) => f(a)(b)
method uncurry2[A, B, C](f: A => B => C): (A, B) => C = (a, b) => { var res := f(a)(b); res };

/*
// Times out
method rep1[A](n: int)(f: A => A)(a: A) = {
  requires (n >= 0)
  repeat1(n)(f)(a)
}
method rep2[A](n: int)(f: A => A)(a: A) = {
  requires (n >= 0)
  repeat2(n)(f)(a)
}
// Said to be non-equivalent, even though they are :(
method repeat1[A](n: int)(f: A => A): A => A = {
  requires (n >= 0)
  decreases(n)
  a => {
    if (n == 0) a
    else repeat1(n - 1)(f)(f(a))
  }
}
method repeat2[A](n: int)(f: A => A): A => A = {
  requires (n >= 0)
  decreases(n)
  if (n == 0) a => a
  else a => repeat2(n - 1)(f)(f(a))
}
*/

method repeat1[A](n: int)(f: A => A): A => A = {
  requires (n >= 0)
  decreases(n)
  a => {
    if (n == 0) a
    else repeat1(n - 1)(f)(f(a))
  }
}
method repeat2[A](n: int)(f: A => A): A => A = {
  requires (n >= 0)
  decreases(n)
  a => {
    if (n == 0) a
    else {
      var fa := f(a);
      repeat1(n - 1)(f)(fa)
    }
  }
}

