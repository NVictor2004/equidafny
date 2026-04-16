package translation.program

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateExpr
import translation.types.translateType
import translation.specification.translateSpec
import translation.statement.translateBlockStmt
import translation.translation.Context

import ujson.Value

import scala.collection.immutable.ListMap

def translateProgram(prog: List[Parsers.TopLevel], config: Value): Program = {

  val functionData = prog.collect {
    case Parsers.Function(name, _, params, _, _, _) => 
      name -> params.map { case Parsers.Parameter(name, _) => name
        }
  }.toMap

  val (data, functions, lemmas) =
    prog.foldLeft((Nil, Nil, Nil))((acc, toplevel) => translateTopLevel(acc, toplevel, functionData))

  val modelFunctionName = config("model").str
  val candidateFunctionNames = config("candidates").arr.map(_.str)

  val normFunctionName = config.obj.get("norm").map(_.str)
  val normFunction = normFunctionName.map(name => functions.find(_.name == name).getOrElse(
    throw new Exception(s"Normalisation function ${name} not found")
  ))

  val modelFunction = functions
    .find(_.name == modelFunctionName)
    .getOrElse(
      throw new Exception(s"Model function ${modelFunctionName} not found")
    )

  val candidateFunctions =
    functions.filter(function => candidateFunctionNames.contains(function.name))

  if (candidateFunctions.length != candidateFunctionNames.length) {
    val foundNames = candidateFunctions.map(_.name).toSet
    val missingNames = candidateFunctionNames.filterNot(foundNames.contains)
    throw new Exception(
      s"Candidate functions not found: ${missingNames.mkString(", ")}"
    )
  }

  val helperFunctionsList = functions.filterNot(function =>
    function.name == modelFunctionName || 
    normFunctionName.fold(false)(name => function.name == name) || 
    candidateFunctionNames.contains(
      function.name
    )
  )

  val helperFunctionsMap = helperFunctionsList.map(func => (func.name, func)).toMap

  Program(
    data,
    modelFunction,
    candidateFunctions,
    helperFunctionsMap,
    normFunction,
    Nil,
    Nil,
    lemmas
  )
}

def translateDeclaredType(decl: Parsers.DeclaredType)(using Context): DeclaredType =
  DeclaredType(
    decl.name,
    decl.typeParams.map(typeParamList => ListMap(typeParamList.map { case Parsers.Parameter(name, paramType) =>
      (name, translateType(paramType))
    }*)).getOrElse(ListMap())
  )

def translateGeneric(
    generic: Option[List[(String, Option[Parsers.GOption])]]
): List[(String, Option[GOption])] = 
  generic.map(_.map { case (gname, gopt) =>
    (
      gname,
      gopt.map {
        case Parsers.Equals => Equals
        case Parsers.NotNew => NotNew
      }
    )
  }).getOrElse(Nil)

def translateTopLevel(
    acc: (
        data: List[Datatype],
        functions: List[Function],
        lemmas: List[Lemma]
    ),
    toplevel: Parsers.TopLevel,
    functionData: Map[String, List[String]]
): (List[Datatype], List[Function], List[Lemma]) = {
  toplevel match {
    case Parsers.Datatype(name, generic, types) => {
      val mapping = 
        generic.map(_.map(_._1)).getOrElse(Nil)
               .zip(('A' to 'Z').map(_.toString)).toMap
      given context: Context = Context(functionData, mapping)

      val item = Datatype(
        name,
        translateGeneric(generic.map(_.map((t, g) => (mapping(t), g)))),
        types.map(translateDeclaredType)
      )
      (item :: acc.data, acc.functions, acc.lemmas)
    }

    case Parsers.Function(name, generic, params, returnType, specs, body) => {
      val types = generic.map(_.map(_._1)).getOrElse(Nil)
      val mapping = types.zip(('A' to 'Z').map(_.toString)).toMap
      given context: Context = Context(functionData, mapping)

      val item = Function(
        false,
        name,
        translateGeneric(generic.map(_.map((t, g) => (mapping(t), g)))),
        ListMap(params.map { case Parsers.Parameter(name, paramType) =>
          (name, translateType(paramType))
        }*),
        translateType(returnType),
        specs.map(translateSpec),
        translateExpr(body)
      )
      (acc.data, item :: acc.functions, acc.lemmas)
    }
    case Parsers.GhostFunction(
          name,
          generic,
          params,
          returnType,
          specs,
          body
        ) => {
      val types = generic.map(_.map(_._1)).getOrElse(Nil)
      val mapping = types.zip(('A' to 'Z').map(_.toString)).toMap
      given context: Context = Context(functionData, mapping)
      
      val item = Function(
        true,
        name,
        translateGeneric(generic.map(_.map((t, g) => (mapping(t), g)))),
        ListMap(params.map { case Parsers.Parameter(name, paramType) =>
          (name, translateType(paramType))
        }*),
        translateType(returnType),
        specs.map(translateSpec),
        translateExpr(body)
      )
      (acc.data, item :: acc.functions, acc.lemmas)
    }
    case Parsers.Lemma(name, generic, params, specs, body) => {
      val types = generic.map(_.map(_._1)).getOrElse(Nil)
      val mapping = types.zip(('A' to 'Z').map(_.toString)).toMap
      given context: Context = Context(functionData, mapping)

      val item = Lemma(
        name,
        translateGeneric(generic.map(_.map((t, g) => (mapping(t), g)))),
        ListMap(params.map { case Parsers.Parameter(name, paramType) =>
          (name, translateType(paramType))
        }*),
        specs.map(translateSpec),
        body.map { case Parsers.BlockStmt(stmts) =>
          translateBlockStmt(stmts)
        }
      )
      (acc.data, acc.functions, item :: acc.lemmas)
    }
  }
}
  
