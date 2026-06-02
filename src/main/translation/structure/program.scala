package translation.structure

import scala.collection.immutable.ListMap

// The main data structure to store a Dafny program
case class Program(
    datatypes: List[Datatype],
    constants: List[TopLevelConstant],
    modelFunction: Function,
    candFunctions: List[Function],
    helperFunctions: Map[String, Function],
    normFunction: Option[Function],
    typeFunctions: Map[Type, Function],
    mainLemmas: List[Lemma],
    helperLemmas: List[Lemma],
    auxiliaryLemmas: List[Lemma]
)

// Data structures to store each possible top-level structure
case class Datatype(
    name: String,
    generic: List[(String, Option[GOption])],
    types: List[DeclaredType]
)
case class TopLevelConstant(
    name: String,
    t: Type,
    data: BasicExpr
)
case class Function(
    ghost: Boolean,
    name: String,
    generic: List[(String, Option[GOption])],
    params: ListMap[String, Type],
    returnType: Type,
    specs: List[Spec],
    body: ExprBlock
)
case class Lemma(
    name: String,
    generic: List[(String, Option[GOption])],
    params: ListMap[String, Type],
    specs: List[Spec],
    body: Option[BlockStmt]
)

// Helper data structures
case class DeclaredType(name: String, typeParams: ListMap[String, Type])

sealed trait GOption
case object Equals extends GOption
case object NotNew extends GOption
