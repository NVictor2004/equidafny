package s12

object s12_5338a6062b02b528279781d89a180692:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    
    def rec_prime(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1 && i <= n)
      if (i < n && n % i == 0) then false 
      //else if i > Prime.isqrtM(n) || i >= n then true
      else if i >= n then true
      else rec_prime(n, i + 1)
    
    if (n == 0 || n == 1) then 
      false
    else
      rec_prime(n, 2)
