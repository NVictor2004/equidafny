package parsers.statement

import parsley.Parsley
import parsley.Parsley.{many, atomic}
import parsley.combinator.{option, sepBy}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic
import parsers.pattern.pattern


lazy val block = BlockStmt("{" ~> many(stmt) <~ "}")

private lazy val elseBlock: Parsley[CondStmt | BlockStmt] = block | condStmt
private lazy val condStmt: Parsley[CondStmt] = CondStmt("if" ~> basic, block, option("else" ~> elseBlock))

private lazy val stmt: Parsley[Stmt] = 
    CallStmt(ident, "(" ~> sepBy(basic, ",") <~ ")" <~ ";")
    | MatchStmt("match" ~> basic,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> many(stmt)) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> many(stmt))
    )
    | AssertStmt("assert" ~> basic <~ ";")
    | LetStmt(atomic("var" ~> lvalue <~ ":="), basic <~ ";")
    | LetOrFailStmt("var" ~> ident <~ ":|", basic <~ ";")
    | condStmt
    | block

private lazy val lvalue =
    "(" ~> sepBy(ident, ",") <~ ")"
    | ident.map(List(_))