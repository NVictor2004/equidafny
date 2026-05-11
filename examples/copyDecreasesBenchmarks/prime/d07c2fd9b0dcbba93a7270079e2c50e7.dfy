package s12

import stainless.lang._


object s12_d07c2fd9b0dcbba93a7270079e2c50e7:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrimeA(n: BigInt): Boolean =
    require(n >= 0)
    
    def rec_prime(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1 && i <= n)
      decreases(n-i)
      if (i >= n) then true
      else if (n % i == 0) then false 
      // else if i > Prime.isqrtM(n) || i >= n then true
      // else if i >= n then true
      else rec_prime(n, i + 1)
    
    if (n == 0 || n == 1) then 
      false
    else
      rec_prime(n, 2)
