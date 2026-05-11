package s12

object s12_3126019de1957acdbf1d073ef063f3dd:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def rec(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && 2 <= i && i <= n)
      if i == n then true
      else if n % i == 0 then false
      else rec(n, i + 1)
    if n < 2 then false
    else rec(n, 2)
