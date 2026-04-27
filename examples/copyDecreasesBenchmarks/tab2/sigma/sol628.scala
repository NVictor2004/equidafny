import stainless.collection._
import stainless.lang._
object C_sigma_sol628 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sum(i: BigInt, z: BigInt): BigInt = {
      if (i >= b + BigInt(1)) z 
      else sum(i + BigInt(1), z + f(i))
    }
    sum(a, BigInt(0))
  }
}
