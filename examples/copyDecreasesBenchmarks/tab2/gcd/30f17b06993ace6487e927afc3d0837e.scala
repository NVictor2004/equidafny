package s13

object s13_30f17b06993ace6487e927afc3d0837e:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    
    if (a == 0) then b
    else if (b == 0) then a
    else 
      val big = (if a > b then a else b)
      val small = (if big == a then b else a)

      val remind = big % small

      gcd(small, remind)
      // if remind == 0 then small
      // else if remind == 1 then 1
      // else 
      //   assert(remind < a && remind < b)
      //   gcd(small, remind)
