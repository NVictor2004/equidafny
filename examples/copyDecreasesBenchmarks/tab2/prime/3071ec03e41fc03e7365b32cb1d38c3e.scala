package s12

object s12_3071ec03e41fc03e7365b32cb1d38c3e:

  /** @param n
    *   A natural number
    * @return
    *   Boolean about the primality of the given natural number n
    */

  def isPrime(n: BigInt): Boolean =
    require(n >= 0)
    def helper(n : BigInt, i : BigInt = 2): Boolean =

      if i < 2 then helper(n,2)
      else if n <= 1 then false
      else if n == 2 then true
      else if n % i == 0 then false
      else if i > Prime.isqrtM(n) then true
      else helper(n, i + 1)

    helper(n)