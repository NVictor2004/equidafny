package parsers.structure

import parsley.templates.{PureParserBridge2, PureParserBridge5}

case class Parameter(name: String, paramType: Type)
object Parameter extends PureParserBridge2[String, Type, Parameter]

case class Function(name: String, params: List[Parameter], returnType: Type, specs: List[Spec], body: Expr)
object Function extends PureParserBridge5[String, List[Parameter], Type, List[Spec], Expr, Function]



