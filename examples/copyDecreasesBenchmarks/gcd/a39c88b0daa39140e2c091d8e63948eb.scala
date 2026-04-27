package s13

object s13_a39c88b0daa39140e2c091d8e63948eb:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  /* First version very bad opti
    def recHelper(a :Int, b : Int): Int =
      if a == b then a 
      else if a > b then recHelper(a - b, b)
      else recHelper(a, b - a)
    recHelper(a, b) */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    

    //AICC 2 version
    def recHelper2(a: Int, b : Int):Int =
      if b == 0 then a
      else recHelper2(b, a % b)
    recHelper2(a, b)

