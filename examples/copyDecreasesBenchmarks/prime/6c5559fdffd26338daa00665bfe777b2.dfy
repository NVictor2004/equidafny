package s12

import scala.runtime.stdLibPatches.language.experimental.saferExceptions

object s12_6c5559fdffd26338daa00665bfe777b2:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def rec(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1, i <= n-1)
      !(n % i == 0) && (i == n-1 || rec(n, i + 1))
      
    if n == 0 || n == 1 then false 
    else n == 2 || rec(n, 2)


