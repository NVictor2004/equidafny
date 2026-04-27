package s12

object s12_b4302a9634980b8f6d047a5250d7678f:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    if n == 0 then false
    else if n == 1 then false 
    else
      def rec(n: BigInt, i: BigInt): BigInt = 
        require(i> 1)
        if i == n then n
        else if n % i == 0 then 0
        else rec(n, i + 1)
      n == rec(n, 2)
