package s13

object s13_58fd0bc94ea5b95f4bc3f1b0a4a19e13:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if (b == 0) then
      a
    else 
      gcd(b, a % b)
