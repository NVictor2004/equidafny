package s13

object s13_09b128596081110f44a02fe6a58b45d2:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    val (big, small) = if a >= b then (a, b) else (b, a)
    if small == 0 then big else 
      gcd(small, big % small)
