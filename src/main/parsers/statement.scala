package parsers.statement

import parsley.Parsley
import parsley.Parsley.many
import parsley.combinator.{option, sepBy}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.expr


lazy val block = "{" ~> many(stmt) <~ "}"
lazy val elseBlock: Parsley[CondStmt | List[Stmt]] = block | condStmt
lazy val condStmt: Parsley[CondStmt] = CondStmt("if" ~> expr, block, option("else" ~> elseBlock))
lazy val call = Call(ident, "(" ~> sepBy(expr, ",") <~ ")" <~ ";")
lazy val stmt = condStmt | call