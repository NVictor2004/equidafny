package equivalence.pattern

import translation.structure.* 

def getIdentsFromPattern(pattern: Pattern): List[String] = pattern match {
    case UnNamed => Nil
    case Constant(_) => Nil
    case Basic(name, values) => name :: values.flatMap(getIdentsFromPattern)
    case PatternTuple(elements) => elements.flatMap(getIdentsFromPattern)
}

def containsUnNamed(pattern: Pattern): Boolean = pattern match {
    case UnNamed => true
    case Constant(_) => false
    case Basic(_, values) => listContainsUnNamed(values)
    case PatternTuple(elements) => listContainsUnNamed(elements)
}

def listContainsUnNamed(patterns: List[Pattern]): Boolean = 
    patterns.foldLeft(false)((acc, pattern) => acc || containsUnNamed(pattern))

