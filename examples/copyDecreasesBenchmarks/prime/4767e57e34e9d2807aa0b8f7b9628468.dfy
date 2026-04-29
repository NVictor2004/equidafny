package s12

object s12_4767e57e34e9d2807aa0b8f7b9628468:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def loop(n: BigInt, i: BigInt): Boolean =
      if i < 2 then true
      else if n % i == 0 then false
      else loop(n, i - 1)
    if n < 2 then false
    else loop(n, Prime.isqrtM(n))
