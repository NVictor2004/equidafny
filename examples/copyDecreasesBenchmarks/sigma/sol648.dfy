import stainless.collection._
import stainless.lang._
object C_sigma_sol648 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0)
    else if (x == y) f(y) 
    else sigma(f, x + BigInt(1), y) + f(x)
  }
}
