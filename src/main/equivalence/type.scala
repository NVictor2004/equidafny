package equivalence.types

import translation.structure.*

def getListOfTypes(t: DomainType): List[Type] = t match {
    case TupleType(elements) => elements
    case t => List(t)
}

