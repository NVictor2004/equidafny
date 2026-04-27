package s13

object s13_9870b2e1b19cf152f339be2ffa8546bf:

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
    else if a > b then gcd(a - b, b)
    else gcd(a, b - a)
    


    
// ===== GCD with list of divisors =====  
  // def gcd(a: Int, b: Int): Int =
  //   require(a >= 0 && b >= 0)
    
  //   val small = (if a < b then a else b)

  //   val divisors = 
  //     (for 
  //       i <- (1 to small).reverse
  //       if (a % i == 0 && b % i == 0)
  //     yield i).toList
    
  //   divisors match
  //     case head :: next => head
  //     case Nil => 
  //       if a == 0 then b
  //       else if b == 0 then a
  //       else 0


// ===== GCD with eucdlidian algorithm =====
  // def gcd(a: Int, b: Int): Int =
  //   require(a >= 0 && b >= 0)
    
  //   if (a == 0) then b
  //   else if (b == 0) then a
  //   else 
  //     val big = (if a > b then a else b)
  //     val small = (if big == a then b else a)

  //     val remind = big % small

  //     // with this end : (or ...)
  //     gcd(small, remind)
      
  //     // This one :
  //     // if remind == 0 then small
  //     // else if remind == 1 then 1
  //     // else 
  //     //   assert(remind < a && remind < b)
  //     //   gcd(small, remind)
