package s12

object s12_56dfba91e22774fef153b12fa8555bdf:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def isPrimeHelper(n : BigInt, i : BigInt) : Boolean = 
      if i == 1 | i == 0 then true 
      else n%i != 0 && isPrimeHelper(n, i-1)
    if n == 0 | n == 1 then false 
    else isPrimeHelper(n, Prime.isqrtM(n))

