package translation.structure

case class DeclaredType(name: String, typeParams: Option[List[Parameter]])
case class Datatype(
    name: String,
    generic: Option[List[(String, Option[GOption])]],
    types: List[DeclaredType]
)

case class Parameter(name: String, paramType: Type)
case class Function(
    ghost: Boolean,
    name: String,
    generic: Option[List[(String, Option[GOption])]],
    params: List[Parameter],
    returnType: Type,
    specs: List[Spec],
    body: ExprBlock
)
case class Lemma(
    name: String,
    generic: Option[List[(String, Option[GOption])]],
    params: List[Parameter],
    specs: List[Spec],
    body: Option[BlockStmt]
)

case class Program(
    datatypes: List[Datatype],
    functions: List[Function],
    lemmas: List[Lemma]
)

sealed trait GOption
case object Equals extends GOption
case object NotNew extends GOption
