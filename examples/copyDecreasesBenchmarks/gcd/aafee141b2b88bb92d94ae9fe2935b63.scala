package s13

object s13_aafee141b2b88bb92d94ae9fe2935b63:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if(b>a) then
      gcd(b,a)
    else
      if (b == 0) then
        a
      else 
        gcd(b, a % b)
