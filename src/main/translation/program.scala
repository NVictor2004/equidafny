package translation.program

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateExpr
import translation.types.translateType
import translation.specification.translateSpec
import translation.statement.translateBlockStmt
import translation.translation.Context

import ujson.Value

def translateProgram(prog: List[Parsers.TopLevel], config: Value): Program = {

  val functionData = prog.collect {
    case Parsers.Function(name, _, params, _, _, _) => 
      name -> params.map { case Parsers.Parameter(name, paramType) =>
          Parameter(name, translateType(paramType))
        }
  }.toMap

  given context: Context = Context(functionData)

  val (data, functions, lemmas) =
    prog.foldLeft((Nil, Nil, Nil))(translateTopLevel)

  val modelFunctionName = config("model").str
  val candidateFunctionNames = config("candidates").arr.map(_.str)

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
    function.name == modelFunctionName || candidateFunctionNames.contains(
      function.name
    )
  )

  val helperFunctionsMap = helperFunctionsList.map(func => (func.name, func)).toMap

  Program(
    data,
    modelFunction,
    candidateFunctions,
    helperFunctionsMap,
    Nil,
    Nil,
    lemmas
  )
}

def translateDeclaredType(decl: Parsers.DeclaredType): DeclaredType =
  DeclaredType(
    decl.name,
    decl.typeParams.map(_.map { case Parsers.Parameter(name, paramType) =>
      Parameter(name, translateType(paramType))
    })
  )

def translateGeneric(
    generic: Option[List[(String, Option[Parsers.GOption])]]
): Option[List[(String, Option[GOption])]] =
  generic.map(_.map { case (gname, gopt) =>
    (
      gname,
      gopt.map {
        case Parsers.Equals => Equals
        case Parsers.NotNew => NotNew
      }
    )
  })

def translateTopLevel(
    acc: (
        data: List[Datatype],
        functions: List[Function],
        lemmas: List[Lemma]
    ),
    toplevel: Parsers.TopLevel
)(using Context): (List[Datatype], List[Function], List[Lemma]) =
  toplevel match {
    case Parsers.Datatype(name, generic, types) => {
      val item = Datatype(
        name,
        translateGeneric(generic),
        types.map(translateDeclaredType)
      )
      (item :: acc.data, acc.functions, acc.lemmas)
    }

    case Parsers.Function(name, generic, params, returnType, specs, body) => {
      val item = Function(
        false,
        name,
        translateGeneric(generic),
        params.map { case Parsers.Parameter(name, paramType) =>
          Parameter(name, translateType(paramType))
        },
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
      val item = Function(
        true,
        name,
        translateGeneric(generic),
        params.map { case Parsers.Parameter(name, paramType) =>
          Parameter(name, translateType(paramType))
        },
        translateType(returnType),
        specs.map(translateSpec),
        translateExpr(body)
      )
      (acc.data, item :: acc.functions, acc.lemmas)
    }
    case Parsers.Lemma(name, generic, params, specs, body) => {
      val item = Lemma(
        name,
        translateGeneric(generic),
        params.map { case Parsers.Parameter(name, paramType) =>
          Parameter(name, translateType(paramType))
        },
        specs.map(translateSpec),
        body.map { case Parsers.BlockStmt(stmts) =>
          translateBlockStmt(stmts)
        }
      )
      (acc.data, acc.functions, item :: acc.lemmas)
    }
  }
