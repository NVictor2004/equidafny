package formatter.expression

import translation.structure.*
import formatter.program.Formatter

def formatLiteral(literal: LiteralExpr)(using writer: Formatter): Unit = literal match {
    case BoolLiteral(value) => writer.format("%b", value)
    case CharLiteral(value) => writer.format("'%c'", value)
    case IntLiteral(value) => writer.format("%d", value)
    case StringLiteral(value) => writer.format("\"%s\"", value)
    case RealLiteral(value) => writer.format("%f", value)
    case Null => writer.format("null")
}
def formatBasicExpr(expr: BasicExpr)(using writer: Formatter): Unit = expr match {
    case expr: LiteralExpr => formatLiteral(expr)
    case Iff(l, r) => {
        formatBasicExpr(l)
        writer.print(" <==> ")
        formatBasicExpr(r)
    }
    case LeftImplies(l, r) => {
        formatBasicExpr(l)
        writer.print(" <== ")
        formatBasicExpr(r)
    }
    case RightImplies(l, r) => {
        formatBasicExpr(l)
        writer.print(" ==> ")
        formatBasicExpr(r)
    }
    case BoolAnd(l, r) => {
        formatBasicExpr(l)
        writer.print(" && ")
        formatBasicExpr(r)
    }
    case BoolOr(l, r) => {
        formatBasicExpr(l)
        writer.print(" || ")
        formatBasicExpr(r)
    }
    case Eq(l, r) => {
        formatBasicExpr(l)
        writer.print(" == ")
        formatBasicExpr(r)
    }
    case Neq(l, r) => {
        formatBasicExpr(l)
        writer.print(" != ")
        formatBasicExpr(r)
    }
    case LT(l, r) => {
        formatBasicExpr(l)
        writer.print(" < ")
        formatBasicExpr(r)
    }
    case LTE(l, r) => {
        formatBasicExpr(l)
        writer.print(" <= ")
        formatBasicExpr(r)
    }
    case GT(l, r) => {
        formatBasicExpr(l)
        writer.print(" > ")
        formatBasicExpr(r)
    }
    case GTE(l, r) => {
        formatBasicExpr(l)
        writer.print(" >= ")
        formatBasicExpr(r)
    }
    case In(l, r) => {
        formatBasicExpr(l)
        writer.print(" in ")
        formatBasicExpr(r)
    }
    case NotIn(l, r) => {
        formatBasicExpr(l)
        writer.print(" !in ")
        formatBasicExpr(r)
    }
    case Disjoint(l, r) => {
        formatBasicExpr(l)
        writer.print(" !! ")
        formatBasicExpr(r)
    }
    case LeftShift(l, r) => {
        formatBasicExpr(l)
        writer.print(" << ")
        formatBasicExpr(r)
    }
    case RightShift(l, r) => {
        formatBasicExpr(l)
        writer.print(" >> ")
        formatBasicExpr(r)
    }
    case Add(l, r) => {
        formatBasicExpr(l)
        writer.print(" + ")
        formatBasicExpr(r)
    }
    case Sub(l, r) => {
        formatBasicExpr(l)
        writer.print(" - ")
        formatBasicExpr(r)
    }
    case Mul(l, r) => {
        formatBasicExpr(l)
        writer.print(" * ")
        formatBasicExpr(r)
    }
    case Div(l, r) => {
        formatBasicExpr(l)
        writer.print(" / ")
        formatBasicExpr(r)
    }
    case Mod(l, r) => {
        formatBasicExpr(l)
        writer.print(" % ")
        formatBasicExpr(r)
    }
    case BitOr(l, r) => {
        formatBasicExpr(l)
        writer.print(" | ")
        formatBasicExpr(r)
    }
    case BitAnd(l, r) => {
        formatBasicExpr(l)
        writer.print(" & ")
        formatBasicExpr(r)
    }
    case BitXor(l, r) => {
        formatBasicExpr(l)
        writer.print(" ^ ")
        formatBasicExpr(r)
    }
    case Neg(e) => {
        writer.print("-")
        formatBasicExpr(e)
    }
    case Not(e) => {
        writer.print("!")
        formatBasicExpr(e)
    }
    case Forall(variable, varType, body) => {
        writer.format("forall %s", variable)
        varType.foreach(t => writer.format(": %s", t))
        writer.print(" :: ")
        formatBasicExpr(body)
    }
    case Exists(variable, varType, body) => {
        writer.format("exists %s", variable)
        varType.foreach(t => writer.format(": %s", t))
        writer.print(" :: ")
        formatBasicExpr(body)
    }
    case Ident(name, suffixes) => {
        writer.format(name)
        suffixes.foreach(s => writer.format(".%s", s))
    }
    case Cardinality(e) => {
        writer.print("|")
        formatBasicExpr(e)
        writer.print("|")
    }
    case Tuple(es) => ???
    case Brackets(e) => ???
    case Cond(cond, thenBranch, elseBranch) => ???
    case FunctionCall(name, args) => ???
    case LambdaCall(lambda, args) => ???
    case Match(expr, cases) => ???
    case Set(es) => ???
    case Seq(es) => ???
    case Lambda(lvalues, body) => ???
    case SeqIndex(name, indexes) => ???
}