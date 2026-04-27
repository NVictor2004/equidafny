import stainless.collection._
import stainless.lang._
object C_sigma_sol447 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    a > b match {
      case true  => { BigInt(0) }
      case false => { f(a) + sigma(f, a + BigInt(1), b) }
    }
  }
}
