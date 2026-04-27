import stainless.collection._
import stainless.lang._
object C_sigma_sol563 {
  def sigma(ff: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else if (a < b) ff(b) + sigma(ff, a, b - BigInt(1)) else ff(b)
  }
}
