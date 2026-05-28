package parsers.statement

import parsley.Parsley
import parsley.Parsley.many
import parsley.combinator.{option, sepBy}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic
import parsers.pattern.pattern

// Parser for a list of statements
lazy val block = BlockStmt("{" ~> many(stmt) <~ "}")

// Helper parser for the else branch of a conditional statement
private lazy val elseBlock: Parsley[CondStmt | BlockStmt] = block | condStmt

// Helper parser for a conditional statement
private lazy val condStmt: Parsley[CondStmt] =
  CondStmt("if" ~> basic, block, option("else" ~> elseBlock))

// Parser for a single statement
private lazy val stmt: Parsley[Stmt] =
  CallStmt(ident, "(" ~> sepBy(basic, ",") <~ ")" <~ ";")
    | MatchStmt(
      "match" ~> basic,
      "{" ~> many("case" ~> (pattern <~ "=>") <~> many(stmt)) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> many(stmt))
    )
    | AssertStmt("assert" ~> basic <~ ";")
    | "var" ~> (
      (("(" ~> sepBy(ident, ",") <~ ")" <~ ":=") <~> (basic <~ ";")).map((lvalues, right) => LetStmt(lvalues, right))
        | ident <**> (
          (":=" ~> basic <~ ";").map(right => ((lvalue: String) => LetStmt(List(lvalue), right)))
            | (":|" ~> basic <~ ";").map(right => ((lvalue: String) => LetOrFailStmt(lvalue, right)))
        )
    )
    | condStmt
    | block
