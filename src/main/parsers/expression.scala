package parsers.expression

import parsley.Parsley
import parsley.expr.{precedence, Ops, Prefix, InfixL, InfixR}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol

// TODO: ==> and <== should not be interchangeable
// TODO: Within each group, different operators should not associate
// TODO: Parentheses need to be used

lazy val expr: Parsley[Expr] =
precedence(ident.map(Ident(_)), literal, endless)(
    Ops(Prefix)(
    "!" as Not.apply,
    "-" as Neg.apply,
    ),
    Ops(InfixL)(
    "|" as BitOr.apply,
    "&" as BitAnd.apply,
    "^" as BitXor.apply,
    ),
    Ops(InfixL)(
    "*" as Mul.apply,
    "/" as Div.apply,
    "%" as Mod.apply,
    ),
    Ops(InfixL)(
    "+" as Add.apply,
    "-" as Sub.apply,
    ),
    Ops(InfixL)(
    "<<" as LeftShift.apply,
    ">>" as RightShift.apply,
    ),
    Ops(InfixL)(
    "==" as Eq.apply,
    "!=" as Neq.apply,
    "<=" as LTE.apply,
    ">=" as GTE.apply,  
    "<" as LT.apply,
    ">" as GT.apply,
    "in" as In.apply,
    "!in" as NotIn.apply,
    "!!" as Disjoint.apply,
    ),
    Ops(InfixL)(
    "&&" as BoolAnd.apply,
    "||" as BoolOr.apply, 
    ),
    Ops(InfixR)(
    "==>" as RightImplies.apply,
    ),
    Ops(InfixL)(
    "<==" as LeftImplies.apply,
    ),
    Ops(InfixL)(
    "<==>" as Iff.apply,
    )
)

lazy val literal: Parsley[Expr] =
    bool.map(BoolLiteral(_))
    | "null".as(Null)
    | integer.map(IntLiteral(_))
    | real.map(RealLiteral(_))
    | char.map(CharLiteral(_))
    | string.map(StringLiteral(_))

lazy val endless: Parsley[Expr] = ???

