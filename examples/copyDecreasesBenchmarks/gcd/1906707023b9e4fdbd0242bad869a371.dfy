package s13

object s13_1906707023b9e4fdbd0242bad869a371:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    (a, b) match
      case (0, _) => b
      case (_, 0) => a
      case _ =>
        if a > b then gcd(b, a % b)
        else gcd(a, b % a)
