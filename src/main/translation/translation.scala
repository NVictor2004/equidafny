package translation.translation

case class Context(
    functionData: Map[String, List[String]],
    typeData: Map[String, String]
)