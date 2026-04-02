package equivalence.pattern

import translation.structure.* 

def getIdentsFromPattern(pattern: Pattern): List[String] = pattern match {
    case UnNamed => Nil
    case Constant(value) => Nil
    case Basic(name, values) => name :: values.map(_.flatMap(getIdentsFromPattern)).getOrElse(Nil)
    case PatternTuple(elements) => elements.flatMap(getIdentsFromPattern)
}
