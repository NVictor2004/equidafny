package s12

object s12_0dd5650acc59da9ca793db4f9e15194f:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def noDivisorInRange(a: BigInt, b: BigInt, n: BigInt): Boolean =
      require(a >= 2 && n >= 0)  
      if a > b then true 
      else if a == b then n % a != 0
      else n % a != 0 && noDivisorInRange(a + 1, b, n)
    n > 1 && noDivisorInRange(2, Prime.isqrtM(n), n)
  