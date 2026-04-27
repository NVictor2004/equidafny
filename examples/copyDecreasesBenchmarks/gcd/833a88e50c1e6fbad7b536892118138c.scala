package s13

object s13_833a88e50c1e6fbad7b536892118138c:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if(b==0) a
    else gcd(b, a%b)
