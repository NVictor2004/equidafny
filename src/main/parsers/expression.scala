package parsers.expression

import parsley.Parsley
import parsley.expr.{precedence, Ops, Prefix, InfixL, InfixR}
import parsley.Parsley.{atomic, notFollowedBy, many, lookAhead}
import parsley.combinator.{sepBy, option, endBy}
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

lazy val basic: Parsley[Expr] =
precedence(
    endlessBasic,
    Ident(ident, many("." ~> ident)),
    literal,
    Brackets("(" ~> basic <~ ")")
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
    | Cardinality("|" ~> basic <~ "|")
    | Tuple("(" ~> sepBy(basic, ",") <~ ")")

lazy val index = 
    StartSubIndex(atomic(basic <~ ".."))
    | UpdateIndex(atomic(basic <~ ":="), basic)
    | ExprIndex(basic)

lazy val lambda = Lambda(atomic(lvalue <~ "=>"), expr)

lazy val endlessBasic = 
    Cond("if" ~> basic, "then" ~> expr, "else" ~> expr)
    | Match("match" ~> basic,
        "{" ~> many("case" ~> (pattern <~ "=>") <~> expr) <~ "}"
        | many("case" ~> (pattern <~ "=>") <~> expr)
    )
    | FunctionCall(atomic(ident <~ "("), (sepBy(basic, ",") <~ ")", many("(" ~> sepBy(basic, ",") <~ ")")).zipped((x, xs) => x :: xs))
    | Forall("forall" ~> ident, option(atomic(":" ~> typeParser)), "::" ~> basic)
    | Exists("exists" ~> ident, option(atomic(":" ~> typeParser)), "::" ~> basic)
    | SeqIndex(atomic(ident <~ "["), ((index <~ "]"), many("[" ~> index <~ "]")).zipped((i, is) => i :: is))
    | Set("{" ~> sepBy(basic, ",") <~ "}")
    | Seq("[" ~> sepBy(basic, ",") <~ "]")
    | LambdaCall(atomic("(" ~> lambda) <~ ")", "(" ~> sepBy(basic, ",") <~ ")")
    | lambda

lazy val expr = (endBy(endlessSpecial, ";"), basic).zipped {
    case (Nil, e) => List(e)
    case (es, e) => es :+ e
}

lazy val endlessSpecial: Parsley[Expr] = 
    Let(atomic("var" ~> lvalue <~ ":="), basic)
    | atomic(MethodCall(atomic(ident <~ "("), sepBy(basic, ",") <~ ")") <~ lookAhead(";"))
    | LetOrFail("var" ~> ident, option(atomic(":" ~> typeParser)), ":|" ~> basic)
    | Assert("assert" ~> basic)

lazy val lvalue =
    "(" ~> sepBy(ident <~> option(":" ~> typeParser), ",") <~ ")"
    | ident.map(i => List((i, None)))