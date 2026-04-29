package s13

object s13_d05a223d8d89824dcfcd444694936930:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    def checkGcd(a: Int, b: Int, testVal: Int): Int =
      require(testVal > 0)
      if a % testVal == 0 && b % testVal == 0 then testVal
      else checkGcd(a, b, testVal - 1)
    (a,b) match
      case (0,x) => x
      case (x,0) => x
      case (x,y) =>
        if x < y then checkGcd(x,y,x) else checkGcd(x,y,y)
