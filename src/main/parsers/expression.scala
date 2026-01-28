package parsers.expression

import parsley.Parsley
import parsley.expr.{precedence, Ops, Prefix, InfixL, InfixR}
import parsley.Parsley.{atomic, notFollowedBy}
import parsley.combinator.sepBy

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol

// TODO: ==> and <== should not be interchangeable
// TODO: Within each group, different operators should not associate
// TODO: Parentheses need to be used

lazy val expr: Parsley[Expr] =
precedence(endless, Ident(ident), literal, "(" ~> expr <~ ")")(
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
    Eq from "==",
    Neq from "!=",
    LTE from "<=",
    GTE from ">=",  
    LT from "<",
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
    LeftImplies from "<==",
    ),
    Ops(InfixL)(
    Iff from "<==>",
    )
)

lazy val literal: Parsley[Expr] =
    BoolLiteral(bool)
    | ("null" as Null)
    | IntLiteral(integer)
    | RealLiteral(real)
    | CharLiteral(char)
    | StringLiteral(string)
    | Cardinality("|" ~> expr <~ "|")

lazy val endless: Parsley[Expr] = 
    Cond("if" ~> expr, "then" ~> expr, "else" ~> expr)
    | Call(atomic(ident <~ "("), sepBy(expr, ",") <~ ")")   

