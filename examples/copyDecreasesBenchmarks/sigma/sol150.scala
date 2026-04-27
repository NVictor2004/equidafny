import stainless.collection._
import stainless.lang._
object C_sigma_sol150 {
  def sigma(f: BigInt => BigInt, num1: BigInt, num2: BigInt): BigInt = {
    if (num1 == num2) {
      f(num1)
    } else if (num1 < num2) {
      f(num1) + sigma(f, num1 + BigInt(1), num2)
    } else {
      BigInt(0)
    }
  }
}
