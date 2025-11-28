

  // Wrong signature
  method dup[S, T](n: int, t: T, s: S): List[(S, T)] = {
    decreases(if (n <= 0) int(0) else n)
    if (n <= 0) Nil()
    else (s, t) :: dup(n - 1, t, s)
  }

}
