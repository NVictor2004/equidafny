package s13

object s13_982e4893eac8a11d7928a25e79d23230:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if b == 0 then a 
    else gcd(b, a % b)
