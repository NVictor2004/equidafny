package translation.translation

import translation.structure.*

case class Context(
    functionData: Map[String, List[String]],
    typeData: Map[String, String]
)