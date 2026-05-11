package s13

object s13_7fcb30ca88ac24758bd01853d27fe158:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if b > a then gcd(b, a)
    else if b == 0 then a else if a % b == 0 then b else gcd(b, a % b)
