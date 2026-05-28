package translation.translation

// Definition of the Context class
// Used to provide neccessary context during translation
case class Context(
    // A map from the names of defined functions to a list of the 
    // names of their parameters
    functionData: Map[String, List[String]],

    // A set of the names of the defined datatype constants
    datatypeData: Set[String],

    // A set of the generic types defined within a specific top-level structure
    genericTypeData: Set[String]
)