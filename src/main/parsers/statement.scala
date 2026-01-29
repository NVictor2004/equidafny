package parsers.statement

import parsley.Parsley
import parsley.Parsley.many
import parsley.combinator.{option, sepBy}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.expr
import parsers.pattern.pattern


lazy val block = BlockStmt("{" ~> many(stmt) <~ "}")
lazy val elseBlock: Parsley[CondStmt | BlockStmt] = block | condStmt
lazy val condStmt: Parsley[CondStmt] = CondStmt("if" ~> expr, block, option("else" ~> elseBlock))
lazy val call = CallStmt(ident, "(" ~> sepBy(expr, ",") <~ ")" <~ ";")
lazy val matchStmt: Parsley[MatchStmt] = MatchStmt("match" ~> expr,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> many(stmt)) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> many(stmt))
    )
lazy val assertStmt = AssertStmt("assert" ~> expr <~ ";")
lazy val letStmt = LetStmt("var" ~> lvalue, ":=" ~> expr <~ ";")
lazy val stmt: Parsley[Stmt] = condStmt | call | matchStmt | assertStmt | letStmt | block

lazy val lvalue =
    "(" ~> sepBy(ident, ",") <~ ")"
    | ident.map(List(_))