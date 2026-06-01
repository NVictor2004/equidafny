import stainless.lang._

object redgreen {
  sealed trait RedGreenL
  case object Red extends RedGreenL
  case class RedC(data: GreenRedL) extends RedGreenL

  sealed trait GreenRedL
  case object Green extends GreenRedL
  case class GreenC(data: RedGreenL) extends GreenRedL
  
  def countRedsV1(data: RedGreenL): Int = {
      data match {
          case Red => 1
          case RedC(data) => 
              val dataCount = data match {
                  case Green => 0
                  case GreenC(data) => countRedsV1(data)
              }
              1 + dataCount
      }
  }.ensuring(_ >= 0)
  
  // datatype RedGreenT = Red | RedD(Green RedGreenT)
  
  // def countRedsV2 : RedGreenT  -> Nat
  // count the occurrences of the constructor RedD and Red
  // you can write the body
}
