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
      name -> params.map(_.name)
    case Parsers.GhostFunction(name, _, params, _, _, _) => 
      name -> params.map(_.name)
  }.toMap

  val datatypeData = for {
    case Parsers.Datatype(_, _, types) <- prog
    case Parsers.DeclaredType(name, None | Some(Nil)) <- types
  } yield name

  val (data, functions, lemmas) =
    prog.foldLeft((Nil, Nil, Nil))((acc, toplevel) => translateTopLevel(acc, toplevel, functionData, datatypeData.toSet))

  // Find the model function
  val modelFunctionName = config("model").str
  val modelFunction = functions
    .find(_.name == modelFunctionName)
    .getOrElse(
      throw new Exception(s"Model function ${modelFunctionName} not found")
    )
  
  // Find the candidate functions
  val candidateFunctionNames = config("candidates").arr.map(_.str)

  val candidateFunctions =
    functions.filter(function => candidateFunctionNames.contains(function.name))

  if (candidateFunctions.length != candidateFunctionNames.length) {
    val foundNames = candidateFunctions.map(_.name).toSet
    val missingNames = candidateFunctionNames.filterNot(foundNames.contains)
    throw new Exception(
      s"Candidate functions not found: ${missingNames.mkString(", ")}"
    )
  }

  // Find the normalisation function, if defined
  val normFunctionName = config.obj.get("norm").map(_.str)
  val normFunction = normFunctionName.map(name => functions.find(_.name == name).getOrElse(
    throw new Exception(s"Normalisation function ${name} not found")
  ))

  // Find the type transformation function, if defined
  // Create a map from the initial type to the function
  val typeFunctionName = config.obj.get("transform").map(_.str)
  val typeFunction = typeFunctionName.map(name => functions.find(_.name == name).getOrElse(
    throw new Exception(s"Type transformation function ${name} not found")
  ))
  val typeFunctions = typeFunction.fold(Map())(func => Map(func.params.values.head -> func))

  // Create map of all remaining functions
  val helperFunctionsList = functions.filterNot(function =>
    function.name == modelFunctionName || 
    normFunctionName.fold(false)(name => function.name == name) || 
    typeFunctionName.fold(false)(name => function.name == name) || 
    candidateFunctionNames.contains(
      function.name
    )
  )
  val helperFunctionsMap = helperFunctionsList.map(func => (func.name, func)).toMap

  // Create and output a Program
  Program(
    data,
    modelFunction,
    candidateFunctions,
    helperFunctionsMap,
    normFunction,
    typeFunctions,
    Nil,
    Nil,
    lemmas
  )
}

def translateDeclaredType(decl: Parsers.DeclaredType)(using Context): DeclaredType =
  DeclaredType(
    decl.name,
    decl.typeParams.fold(ListMap())(typeParamList => ListMap(typeParamList.map { case Parsers.Parameter(name, paramType) =>
      (name, translateType(paramType))
    }*))
  )

def translateGeneric(
    generic: Option[List[(String, Option[Parsers.GOption])]]
): List[(String, Option[GOption])] = 
  generic.fold(Nil)(_.map { case (gname, gopt) =>
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
    toplevel: Parsers.TopLevel,
    functionData: Map[String, List[String]],
    datatypeData: scala.collection.immutable.Set[String],
): (List[Datatype], List[Function], List[Lemma]) = {
  toplevel match {
    case Parsers.Datatype(name, generic, types) => {
      val genericTypeData = generic.fold(Nil)(_.map(_._1)).toSet
      given context: Context = Context(functionData, datatypeData, genericTypeData)

      val item = Datatype(
        name,
        translateGeneric(generic),
        types.map(translateDeclaredType)
      )
      (item :: acc.data, acc.functions, acc.lemmas)
    }

    case Parsers.Function(name, generic, params, returnType, specs, body) => {
      val genericTypeData = generic.fold(Nil)(_.map(_._1)).toSet
      given context: Context = Context(functionData, datatypeData, genericTypeData)

      val item = Function(
        false,
        name,
        translateGeneric(generic),
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
      val genericTypeData = generic.fold(Nil)(_.map(_._1)).toSet
      given context: Context = Context(functionData, datatypeData, genericTypeData)
      
      val item = Function(
        true,
        name,
        translateGeneric(generic),
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
      val genericTypeData = generic.fold(Nil)(_.map(_._1)).toSet
      given context: Context = Context(functionData, datatypeData, genericTypeData)

      val item = Lemma(
        name,
        translateGeneric(generic),
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
  
