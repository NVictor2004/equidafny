package s12

object s12_e4ab8a0180cb3a6b6851d4de34a91ccd:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    
    def rec(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 0)
      if (i < n && n % i == 0) then false 
      else if i > Prime.isqrtM(n) then true
      else rec(n, i + 1)
    
    if (n == 0 || n == 1) then 
      false
    else
      rec(n, 2)
