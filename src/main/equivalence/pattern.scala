package equivalence.pattern

import translation.structure.* 

private def reverseLookup[A, B](mappings: List[(A, B)], value: B): A = 
    mappings.find((_, v) => v == value).get._1

private def lookup[A, B](mappings: List[(A, B)], key: A): Option[B] = 
    mappings.find((k, _) => k == key).map(_._2)

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

def mapBasicExprToPattern(expr: BasicExpr, pattern: Pattern): List[(String, Pattern)] = (expr, pattern) match {
    case (Tuple(elements), PatternTuple(patternElements)) if elements.length == patternElements.length =>
        elements.zip(patternElements).foldLeft(List()) {
            case (accMap, (expr, pattern)) => accMap ++ mapBasicExprToPattern(expr, pattern)
        }
    case (Ident(name, Nil), pattern) => List((name, pattern))
}

def createPattern(candExpr: BasicExpr, modelCandMapping: Map[String, String], modelPatternMapping: List[(String, Pattern)]): Pattern = candExpr match {
    case Tuple(elements) => PatternTuple(elements.map(element => createPattern(element, modelCandMapping, modelPatternMapping)))
    case Ident(candName, Nil) => {
        val modelName = reverseLookup(modelCandMapping.toList, candName)
        lookup(modelPatternMapping, modelName).getOrElse(UnNamed)
    }
}

def mergePattern(modelPattern: Pattern, candPattern: Pattern): Boolean = (modelPattern, candPattern) match {
    case (_, UnNamed) => true
    case (UnNamed, _) => true
    case (PatternTuple(modelElements), PatternTuple(candElements)) if modelElements.length == candElements.length => 
        modelElements.zip(candElements).foldLeft(true) {
            case (acc, (model, cand)) => acc && mergePattern(model, cand)
        }
    case (model, cand) => model == cand
}
