package s12

object s12_851b821b4d280974879ccb74e92a320b:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def divideLoop(i: BigInt, thresold: BigInt): Boolean =
      if i <= 1 then true
      else if n % i == 0 then false else divideLoop(i-1, thresold)

    val sqrt = Prime.isqrtM(n)
     if sqrt*sqrt == n then false else
      divideLoop(sqrt, sqrt)
       
