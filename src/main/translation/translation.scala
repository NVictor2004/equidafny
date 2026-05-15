package translation.translation

case class Context(
    functionData: Map[String, List[String]],
    datatypeData: List[String],
    typeData: Map[String, String]
)