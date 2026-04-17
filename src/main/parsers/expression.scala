package parsers.expression

import parsley.Parsley
import parsley.expr.{precedence, Ops, Prefix, InfixL, InfixR}
import parsley.Parsley.{atomic, notFollowedBy, many, some, lookAhead}
import parsley.combinator.{sepBy, option, endBy}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.pattern.pattern
import parsers.types.typeParser
import parsers.index.index

lazy val basic: Parsley[BasicExpr] =
  precedence(
    basicHigher,
    literal
  )(
    Ops(Prefix)(
      Not from "!",
      Neg from "-"
    ),
    Ops(InfixL)(
      Mul from "*",
      Div from "/",
      Mod from "%"
    ),
    Ops(InfixL)(
      Add from "+",
      Sub from "-"
    ),
    Ops(InfixL)(
      Eq from atomic("==" <~ notFollowedBy(">")),
      Neq from "!=",
      LTE from atomic("<=" <~ notFollowedBy("=>")),
      GTE from ">=",
      LT from atomic("<" <~ notFollowedBy("==>")),
      GT from ">"
    ),
    Ops(InfixL)(
      BoolAnd from "&&",
      BoolOr from "||"
    ),
    Ops(InfixR)(
      RightImplies from "==>"
    ),
    Ops(InfixL)(
      LeftImplies from atomic("<==" <~ notFollowedBy(">"))
    ),
    Ops(InfixL)(
      Iff from "<==>"
    )
  )

lazy val literal: Parsley[LiteralExpr] =
  BoolLiteral(bool)
    | ("null" as Null)
    | IntLiteral(integer)
    | RealLiteral(real)
    | CharLiteral(char)
    | StringLiteral(string)

private lazy val lambda = Lambda(atomic(lvalue <~ "=>"), expr)

private lazy val basicHigher =
  Cond("if" ~> basic, "then" ~> expr, "else" ~> expr)
    | Match(
      "match" ~> basic,
      "{" ~> many("case" ~> (pattern <~ "=>") <~> expr) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> expr)
    )
    | "forall" ~> ident <**> (
      "::" ~> basic.map(expr => ((varName: String) => Forall(varName, None, expr)))
      | ((":" ~> typeParser <~ "::") <~> basic).map((t, expr) => ((varName: String) => Forall(varName, Some(t), expr)))
    )
    | "exists" ~> ident <**> (
      "::" ~> basic.map(expr => ((varName: String) => Exists(varName, None, expr)))
      | ((":" ~> typeParser <~ "::") <~> basic).map((t, expr) => ((varName: String) => Exists(varName, Some(t), expr)))
    )
    | Set("{" ~> sepBy(basic, ",") <~ "}")
    | Seq("[" ~> sepBy(basic, ",") <~ "]")
    | Cardinality("|" ~> basic <~ "|")
    | LambdaCall(atomic("(" ~> lambda) <~ ")", "(" ~> sepBy(basic, ",") <~ ")")
    | lambda
    | ident <**> (
      some("(" ~> sepBy(basic, ",") <~ ")").map(args =>
        FunctionCall(_: String, args)
      )
        | some("[" ~> index <~ "]").map(idxs => SeqIndex(_: String, idxs))
        | many("." ~> ident).map(suffixes => Ident(_: String, suffixes))
    )
    | "(" ~> basic <**> (
      "," ~> sepBy(basic, ",").map(basics => ((basic: BasicExpr) => Tuple(basic :: basics)))
      </> identity[BasicExpr]
    ) <~ ")"

lazy val expr = ExprBlock(endBy(extendedHigher, ";"), basic)

private lazy val extendedHigher: Parsley[ExtendedExpr] =
  Let(atomic("var" ~> lvalue <~ ":="), basic)
    | atomic(
      MethodCall(ident, "(" ~> sepBy(basic, ",") <~ ")") <~ lookAhead(
        ";"
      )
    )
    | "var" ~> ident <**> (
      ":|" ~> basic.map(expr => ((varName: String) => LetOrFail(varName, None, expr)))
      | ((":" ~> typeParser <~ ":|") <~> basic).map((t, expr) => ((varName: String) => LetOrFail(varName, Some(t), expr)))
    )
    | Assert("assert" ~> basic)

private lazy val lvalue =
  "(" ~> sepBy(ident <~> option(":" ~> typeParser), ",") <~ ")"
    | ident.map(i => List((i, None)))
