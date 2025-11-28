

  // Wrong signature
  def dup[S, T](n: BigInt, t: T, s: S): List[(S, T)] = {
    decreases(if (n <= 0) BigInt(0) else n)
    if (n <= 0) Nil()
    else (s, t) :: dup(n - 1, t, s)
  }

}
