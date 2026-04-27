package s12

object s12_fea922664ab213e2922bf8f1e71998ca:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)

    def primes(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 0)
      if i <= Prime.isqrtM(n) && n % i != 0 then primes(n, i+1)
      else if i > Prime.isqrtM(n) then true
      else false

    if n == 0 || n == 1 then false
    else primes(n, 2)
      
