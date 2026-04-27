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

def mapBasicExprToPattern(expr: BasicExpr, pattern: Pattern): Map[String, Pattern] = (expr, pattern) match {
    case (Tuple(elements), PatternTuple(patternElements)) if elements.length == patternElements.length =>
        elements.zip(patternElements).flatMap((expr, pattern) => mapBasicExprToPattern(expr, pattern)).toMap
    case (Ident(name, Nil), pattern) => Map(name -> pattern)
}

def createPattern(candExpr: BasicExpr, candModelMapping: Map[String, String], modelPatternMapping: Map[String, Pattern]): Pattern = candExpr match {
    case Tuple(elements) => PatternTuple(elements.map(element => createPattern(element, candModelMapping, modelPatternMapping)))
    case Ident(candName, Nil) => {
        val modelName = candModelMapping(candName)
        modelPatternMapping.getOrElse(modelName, UnNamed)
    }
}

def mergePattern(modelPattern: Pattern, candPattern: Pattern): Boolean = (modelPattern, candPattern) match {
    case (_, UnNamed) => true
    case (UnNamed, _) => true
    case (PatternTuple(modelElements), PatternTuple(candElements)) if modelElements.length == candElements.length => 
        modelElements.zip(candElements).forall((model, cand) => mergePattern(model, cand))
    case (model, cand) => model == cand
}
