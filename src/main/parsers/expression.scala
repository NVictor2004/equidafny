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

// TODO: ==> and <== should not be interchangeable
// TODO: Within each group, different operators should not associate
// TODO: Parentheses need to be used

lazy val expr: Parsley[Expr] =
precedence(
    endless,
    Call(atomic(ident <~ "("), sepBy(expr, ",") <~ ")"),
    literal,
    Ident(atomic(ident <~ notFollowedBy("(" | "["))),
    SeqIndex(atomic(ident <~ "["), expr <~ "]"),
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
    Eq from "==",
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

lazy val literal: Parsley[Expr] =
    BoolLiteral(bool)
    | ("null" as Null)
    | IntLiteral(integer)
    | RealLiteral(real)
    | CharLiteral(char)
    | StringLiteral(string)
    | Cardinality("|" ~> expr <~ "|")
    | Tuple("(" ~> sepBy(expr, ",") <~ ")")

lazy val endless: Parsley[Expr] = 
    Cond("if" ~> expr, "then" ~> expr, "else" ~> expr)
    | Let("var" ~> lvalue, ":=" ~> expr, ";" ~> expr)
    | Match("match" ~> expr,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> expr) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> expr)
    )

lazy val lvalue =
    "(" ~> sepBy(ident, ",") <~ ")"
    | ident.map(List(_))

lazy val pattern: Parsley[Pattern] =
        ("_" as UnNamed)
        | Basic(ident, option("(" ~> sepBy(pattern, ",") <~ ")"))
        | PatternTuple("(" ~> sepBy(pattern, ",") <~ ")")

// lazy val identDistinguish = (ident, option("(" ~> sepBy(expr, ",") <~ ")"), option("[" ~> expr <~ "]")).zipped((i, c, s) =>
//         (c, s) match {
//             case (Some(c), _) => Call(i, c)
//             case (_, Some(s)) => SeqIndex(i, s)
//             case _ => Ident(i)
//     })