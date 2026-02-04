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

// TODO: ==> and <== should not be interchangeable
// TODO: Within each group, different operators should not associate
// TODO: Parentheses need to be used

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
      // BitOr from atomic("|" <~ notFollowedBy("|")), TODO: Add this back in
      BitAnd from atomic("&" <~ notFollowedBy("&")),
      BitXor from "^"
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
      LeftShift from "<<",
      RightShift from ">>"
    ),
    Ops(InfixL)(
      Eq from atomic("==" <~ notFollowedBy(">")),
      Neq from "!=",
      LTE from atomic("<=" <~ notFollowedBy("=>")),
      GTE from ">=",
      LT from atomic("<" <~ notFollowedBy("==>")),
      GT from ">",
      In from "in",
      NotIn from "!in",
      Disjoint from "!!"
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

// TODO: Something was wrong with the bool parser here
// TODO: move literal back up in the precedence atom list to see
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
    | Forall(
      "forall" ~> ident,
      option(atomic(":" ~> typeParser)),
      "::" ~> basic
    )
    | Exists(
      "exists" ~> ident,
      option(atomic(":" ~> typeParser)),
      "::" ~> basic
    )
    | Set("{" ~> sepBy(basic, ",") <~ "}")
    | Seq("[" ~> sepBy(basic, ",") <~ "]")
    | Cardinality("|" ~> basic <~ "|")
    | LambdaCall(atomic("(" ~> lambda) <~ ")", "(" ~> sepBy(basic, ",") <~ ")")
    | lambda
    | ident <**> (
      some("(" ~> sepBy(basic, ",") <~ ")").map(args => FunctionCall(_: String, args))
      | some("[" ~> index <~ "]").map(idxs => SeqIndex(_: String, idxs))
      | many("." ~> ident).map(suffixes => Ident(_: String, suffixes))
    )
    | Brackets(atomic("(" ~> basic <~ ")"))
    | Tuple("(" ~> sepBy(basic, ",") <~ ")")

lazy val expr = ExprBlock(endBy(extendedHigher, ";"), basic)

private lazy val extendedHigher: Parsley[ExtendedExpr] =
  Let(atomic("var" ~> lvalue <~ ":="), basic)
    | atomic(
      MethodCall(ident, "(" ~> sepBy(basic, ",") <~ ")") <~ lookAhead(
        ";"
      )
    )
    | LetOrFail(
      "var" ~> ident,
      option(atomic(":" ~> typeParser)),
      ":|" ~> basic
    )
    | Assert("assert" ~> basic)

private lazy val lvalue =
  "(" ~> sepBy(ident <~> option(":" ~> typeParser), ",") <~ ")"
    | ident.map(i => List((i, None)))
