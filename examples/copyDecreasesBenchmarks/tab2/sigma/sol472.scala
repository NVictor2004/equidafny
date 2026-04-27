import stainless.collection._
import stainless.lang._
object C_sigma_sol472 {
  def sigma(udf: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0) else udf(x) + sigma(udf, x + BigInt(1), y)
  }
}
