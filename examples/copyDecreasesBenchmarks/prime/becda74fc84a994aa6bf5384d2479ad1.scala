package s12

object s12_becda74fc84a994aa6bf5384d2479ad1:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    
    def rec_prime(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1)
      if (i < n && n % i == 0) then false 
      else if i > Prime.isqrtM(n) then true
      else rec_prime(n, i + 1)
    
    if (n == 0 || n == 1) then 
      false
    else
      rec_prime(n, 2)
