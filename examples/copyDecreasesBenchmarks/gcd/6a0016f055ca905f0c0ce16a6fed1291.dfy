package s13

object s13_6a0016f055ca905f0c0ce16a6fed1291:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if(a>b) then gcd(b,a)
    else if(a==0) then b
    else gcd(b%a,a)
