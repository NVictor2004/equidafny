package s13

object s13_f496b152f1013411372f98594ea6f8be:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a == 0 then b 
    else if b == 0 then a 
    else if a > b then gcd(b, a % b)
    else gcd(a, b % a)
