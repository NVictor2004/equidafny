package translation.program

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateExpr
import translation.types.translateType
import translation.specification.translateSpec
import translation.statement.translateBlockStmt

def translateProgram(prog: List[Parsers.TopLevel]): Program = {
  val (data, functions, ghostFunctions, lemmas) =
    prog.foldLeft((Nil, Nil, Nil, Nil))(translateTopLevel)
  Program(data, functions, ghostFunctions, lemmas)
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
        ghostFunctions: List[GhostFunction],
        lemmas: List[Lemma]
    ),
    toplevel: Parsers.TopLevel
): (List[Datatype], List[Function], List[GhostFunction], List[Lemma]) =
  toplevel match {
    case Parsers.Datatype(name, generic, types) =>
      (
        Datatype(
          name,
          translateGeneric(generic),
          types.map(translateDeclaredType)
        ) :: acc.data,
        acc.functions,
        acc.ghostFunctions,
        acc.lemmas
      )
    case Parsers.Function(name, generic, params, returnType, specs, body) =>
      (
        acc.data,
        Function(
          name,
          translateGeneric(generic),
          params.map { case Parsers.Parameter(name, paramType) =>
            Parameter(name, translateType(paramType))
          },
          translateType(returnType),
          specs.map(translateSpec),
          translateExpr(body)
        ) :: acc.functions,
        acc.ghostFunctions,
        acc.lemmas
      )
    case Parsers.GhostFunction(
          name,
          generic,
          params,
          returnType,
          specs,
          body
        ) =>
      (
        acc.data,
        acc.functions,
        GhostFunction(
          name,
          translateGeneric(generic),
          params.map { case Parsers.Parameter(name, paramType) =>
            Parameter(name, translateType(paramType))
          },
          translateType(returnType),
          specs.map(translateSpec),
          translateExpr(body)
        ) :: acc.ghostFunctions,
        acc.lemmas
      )
    case Parsers.Lemma(name, generic, params, specs, body) =>
      (
        acc.data,
        acc.functions,
        acc.ghostFunctions,
        Lemma(
          name,
          translateGeneric(generic),
          params.map { case Parsers.Parameter(name, paramType) =>
            Parameter(name, translateType(paramType))
          },
          specs.map(translateSpec),
          body.map { case Parsers.BlockStmt(stmts) =>
            translateBlockStmt(stmts)
          }
        ) :: acc.lemmas
      )
  }
