package s12

import scala.annotation.tailrec

object s12_ea26121df9f6b7f362c6a1874aa30137:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */
  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    (n >= 2) && MyRange.forallInRange(BigInt(2), Prime.isqrtM(n), {i => require(i != 0); n % i > 0})

object MyRange:
  final def forallInRange(start: BigInt, last: BigInt, p: BigInt => Boolean): Boolean =
    @tailrec def loop(s: BigInt, l: BigInt) : Boolean = s > l || (p(s) && loop(s + 1, l))
    loop(start, last)