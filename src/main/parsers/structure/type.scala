package parsers.structure

sealed trait Type
case object TypeInt extends Type
case object TypeBool extends Type
case object TypeString extends Type
case object TypeChar extends Type