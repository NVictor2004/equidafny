package s12

object s12_8a3d256a7cb88e017d7d30a4b975919a:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    var sqrt = Prime.isqrtM(n)
    var bool = true

    while sqrt > 1 && bool do
      bool &= n % sqrt != 0
      sqrt -= 1
    
    if n == 0 || n == 1 then false else bool
      
