package s12

object s12_9fd79d9eb5ce0aedbbd0abfd39ee7a3f:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def isPrimeRec(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && 2 <= i && i <= n)
      if i == n then true
      else if n % i == 0 then false
      else isPrimeRec(n, i + 1)
    if n < 2 then false
    else isPrimeRec(n, 2)
