package translation.translation

case class Context(
    functionData: Map[String, List[String]],
    datatypeData: Set[String],
    genericTypeData: Set[String]
)