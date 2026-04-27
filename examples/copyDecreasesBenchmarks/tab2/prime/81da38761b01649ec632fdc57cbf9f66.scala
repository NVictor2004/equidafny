package s12

object s12_81da38761b01649ec632fdc57cbf9f66:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    
    def rec_prime(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1 && i <= n)
      if (i == n) then true
      else if (n % i == 0) then false 
      // else if i > Prime.isqrtM(n) || i >= n then true
      // else if i >= n then true
      else rec_prime(n, i + 1)
    
    if (n == 0 || n == 1) then 
      false
    else
      rec_prime(n, 2)
