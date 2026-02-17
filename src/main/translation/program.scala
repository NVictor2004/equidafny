package translation.program

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateExpr
import translation.types.translateType
import translation.specification.translateSpec
import translation.statement.translateBlockStmt

def translateProgram(prog: List[Parsers.TopLevel]): Program = {
  val (data, functions, lemmas) =
    prog.foldLeft((Nil, Nil, Nil))(translateTopLevel)
  Program(data, functions, lemmas)
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
): (List[Datatype], List[Function], List[Lemma]) =
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
