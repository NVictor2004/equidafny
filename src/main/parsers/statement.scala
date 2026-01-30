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
lazy val elseBlock: Parsley[CondStmt | BlockStmt] = block | condStmt
lazy val condStmt: Parsley[CondStmt] = CondStmt("if" ~> basic, block, option("else" ~> elseBlock))
lazy val call = CallStmt(ident, "(" ~> sepBy(basic, ",") <~ ")" <~ ";")
lazy val matchStmt: Parsley[MatchStmt] = MatchStmt("match" ~> basic,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> many(stmt)) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> many(stmt))
    )
lazy val assertStmt = AssertStmt("assert" ~> basic <~ ";")
lazy val letStmt = LetStmt(atomic("var" ~> lvalue <~ ":="), basic <~ ";")
lazy val letOrFailStmt = LetOrFailStmt("var" ~> ident <~ ":|", basic <~ ";")
lazy val stmt: Parsley[Stmt] = condStmt | call | matchStmt | assertStmt | letStmt | block | letOrFailStmt

lazy val lvalue =
    "(" ~> sepBy(ident, ",") <~ ")"
    | ident.map(List(_))