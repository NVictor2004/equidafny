package s12

object s12_ee0602a8c71d8de569d708610b3fba91:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    if n == BigInt(0) || n == BigInt(1) then false
    else {
      var i = BigInt(2)
      val iMax = Prime.isqrtM(n)
      while i <= iMax do
        if i != 0 &&  n % i == 0 then return false 
        i = i + 1
      return true
    }
