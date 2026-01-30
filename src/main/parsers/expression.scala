package parsers.expression

import parsley.Parsley
import parsley.expr.{precedence, Ops, Prefix, InfixL, InfixR}
import parsley.Parsley.{atomic, notFollowedBy, many}
import parsley.combinator.{sepBy, option}
import parsley.syntax.zipped.*

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.pattern.pattern
import parsers.types.typeParser

// TODO: ==> and <== should not be interchangeable
// TODO: Within each group, different operators should not associate
// TODO: Parentheses need to be used

lazy val expr: Parsley[Expr] =
precedence(
    endless,
    Ident(atomic(ident <~ notFollowedBy("(" | "["))),
    literal,
    "(" ~> expr <~ ")"
)(
    Ops(Prefix)(
    Not from "!",
    Neg from "-",
    ),
    Ops(InfixL)(
    // BitOr from atomic("|" <~ notFollowedBy("|")), TODO: Add this back in
    BitAnd from atomic("&" <~ notFollowedBy("&")),
    BitXor from "^",
    ),
    Ops(InfixL)(
    Mul from "*",
    Div from "/",
    Mod from "%",
    ),
    Ops(InfixL)(
    Add from "+",
    Sub from "-",
    ),
    Ops(InfixL)(
    LeftShift from "<<",
    RightShift from ">>",
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
    Disjoint from "!!",
    ),
    Ops(InfixL)(
    BoolAnd from "&&",
    BoolOr from "||", 
    ),
    Ops(InfixR)(
    RightImplies from "==>",
    ),
    Ops(InfixL)(
    LeftImplies from atomic("<==" <~ notFollowedBy(">")),
    ),
    Ops(InfixL)(
    Iff from "<==>",
    )
)

// TODO: Something was wrong with the bool parser here
// TODO: move literal back up in the precedence atom list to see
lazy val literal: Parsley[Expr] =
    BoolLiteral(bool) 
    | ("null" as Null)
    | IntLiteral(integer)
    | RealLiteral(real)
    | CharLiteral(char)
    | StringLiteral(string)
    | Cardinality("|" ~> expr <~ "|")
    | Tuple("(" ~> sepBy(expr, ",") <~ ")")

lazy val index = 
    StartSubIndex(atomic(expr <~ ".."))
    | UpdateIndex(atomic(expr <~ ":="), expr)
    | ExprIndex(expr)

lazy val endless: Parsley[Expr] = 
    Cond("if" ~> expr, "then" ~> expr, "else" ~> expr)
    | Let(atomic("var" ~> lvalue <~ ":="), expr, ";" ~> expr)
    | LetOrFail("var" ~> ident, option(atomic(":" ~> typeParser)), ":|" ~> expr, ";" ~> expr)
    | Match("match" ~> expr,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> expr) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> expr)
    )
    | Assert("assert" ~> expr, ";" ~> expr)
    | Forall( "forall" ~> ident, option(atomic(":" ~> typeParser)), "::" ~> expr)
    | Call(atomic(ident <~ "("), (sepBy(expr, ",") <~ ")", many("(" ~> sepBy(expr, ",") <~ ")")).zipped((x, xs) => x :: xs))
    | SeqIndex(atomic(ident <~ "["), ((index <~ "]"), many("[" ~> index <~ "]")).zipped((i, is) => i :: is))
    | Set("{" ~> sepBy(expr, ",") <~ "}")
    | Seq("[" ~> sepBy(expr, ",") <~ "]")
    | Lambda(atomic(lvalue <~ "=>"), expr)

lazy val lvalue =
    "(" ~> sepBy(ident <~> option(":" ~> typeParser), ",") <~ ")"
    | ident.map(i => List((i, None)))