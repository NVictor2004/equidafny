package translation.translation

// TODO: Change datatypeData to a Set[String]
case class Context(
    functionData: Map[String, List[String]],
    datatypeData: List[String],
    genericTypeData: Set[String]
)