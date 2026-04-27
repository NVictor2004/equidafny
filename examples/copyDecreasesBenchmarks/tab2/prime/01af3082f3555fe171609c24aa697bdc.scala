package s12

import scala.util.boundary

object s12_01af3082f3555fe171609c24aa697bdc:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    if n <= 1 then false
    else
      val threshold = Prime.isqrtM(n)
      def helper(advancement: BigInt, m: BigInt): Boolean = 
        require(advancement > 0)
        if advancement > threshold then true
        else if m % advancement == 0 then false
        else helper(advancement + 1, m)
      helper(2, n)

      /* 
      val threshold = Prime.isqrtM(n)
      def helper(advancement: BigInt): Boolean = 
        require(advancement > 0)
        if advancement > threshold then true
        else if n % advancement == 0 then false
        else helper(advancement + 1)
      helper(2)
      */
      /*
      (for x <- (BigInt(2) to Prime.isqrtM(n))
        if n % x == 0
      yield n).isEmpty
      */
      /**
        * boundary:
            for x <- (BigInt(2) to Prime.isqrtM(n))
              if n % x == 0
            do boundary.break(false)
            true
        */
