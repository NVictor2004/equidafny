package formatter.expression

import translation.structure.*
import translation.structure.BinaryOperator.*
import translation.structure.UnaryOperator.*
import translation.structure.Quantifier.*
import formatter.formatter.*
import formatter.pattern.formatPattern
import formatter.index.formatIndex
import formatter.types.formatType

def formatLiteral(literal: LiteralExpr)(using writer: Formatter): Unit =
  literal match {
    case BoolLiteral(value)   => writer.print(value.toString())
    case CharLiteral(value)   => writer.format("'%s'", value.toString())
    case IntLiteral(value)    => writer.print(value.toString)
    case StringLiteral(value) => writer.format("\"%s\"", value)
    case RealLiteral(value)   => writer.format("%f", value)
    case Null                 => writer.format("null")
  }

private def formatBinaryOperator(operator: BinaryOperator): String =
  operator match {
    case Iff          => "<==>"
    case LeftImplies  => "<=="
    case RightImplies => "==>"
    case BoolAnd      => "&&"
    case BoolOr       => "||"
    case Eq           => "=="
    case Neq          => "!="
    case LT           => "<"
    case LTE          => "<="
    case GT           => ">"
    case GTE          => ">="
    case In           => "in"
    case NotIn        => "!in"
    case Disjoint     => "!!"
    case LeftShift    => "<<"
    case RightShift   => ">>"
    case Add          => "+"
    case Sub          => "-"
    case Mul          => "*"
    case Div          => "/"
    case Mod          => "%"
    case BitOr        => "|"
    case BitAnd       => "&"
    case BitXor       => "^"
  }

private def formatUnaryOperator(operator: UnaryOperator): String =
  operator match {
    case Neg => "-"
    case Not => "!"
  }

private def formatQuantifier(quantifier: Quantifier): String =
  quantifier match {
    case Forall => "forall"
    case Exists => "exists"
  }

def formatBasicExpr(expr: BasicExpr)(using writer: Formatter): Unit =
  expr match {
    case expr: LiteralExpr             => formatLiteral(expr)
    case Binary(operator, left, right) => {
      formatBasicExpr(left)
      writer.print(s" ${formatBinaryOperator(operator)} ")
      formatBasicExpr(right)
    }
    case Unary(operator, e) => {
      writer.print(formatUnaryOperator(operator))
      formatBasicExpr(e)
    }
    case Quantified(quantifier, variable, varType, body) => {
      writer.format("%s %s", formatQuantifier(quantifier), variable)
      varType.foreach(t => {
        writer.print(": ")
        formatType(t)
      })
      writer.print(" :: ")
      formatBasicExpr(body)
    }
    case Ident(name, suffixes) => {
      writer.format(name)
      suffixes.foreach(s => writer.format(".%s", s))
    }
    case Cardinality(e) => formatBrackets("|", formatBasicExpr(e), "|")
    case Tuple(es) => formatBrackets("(", formatList(es, formatBasicExpr), ")")
    case Brackets(e) => formatBrackets("(", formatBasicExpr(e), ")")
    case Cond(cond, thenBranch, elseBranch) => {
      writer.print("if ")
      formatBasicExpr(cond)
      writer.print(" then ")
      formatExpr(thenBranch)
      writer.print(" else ")
      formatExpr(elseBranch)
    }
    case TrueFunctionCall(name, args) => {
      writer.format("%s", name)
      args.foreach(argList =>
        formatBrackets("(", formatList(argList.map(_._2), formatBasicExpr), ")")
      )
    }
    case OtherFunctionCall(name, args) => {
      writer.format("%s", name)
      args.foreach(argList =>
        formatBrackets("(", formatList(argList, formatBasicExpr), ")")
      )
    }
    case LambdaCall(lambda, args) => {
      formatBrackets("(", formatBasicExpr(lambda), ")")
      formatBrackets("(", formatList(args, formatBasicExpr), ")")
    }
    case Match(expr, cases) => {
      writer.print("match ")
      formatBasicExpr(expr)
      writer.println(" {")
      cases.foreach((pattern, block) => {
        writer.print("case ")
        formatPattern(pattern)
        writer.print(" => ")
        formatExpr(block)
        writer.println("")
      })
      writer.println("}")
    }
    case Set(es) => formatBrackets("{", formatList(es, formatBasicExpr), "}")
    case Seq(es) => formatBrackets("[", formatList(es, formatBasicExpr), "]")
    case Lambda(lvalues, body) => {
      formatBrackets("(", formatList(lvalues, formatLValue), ")")
      writer.print(" => ")
      formatExpr(body)
    }
    case SeqIndex(name, indexes) => {
      writer.format("%s", name)
      indexes.foreach(index => formatBrackets("[", formatIndex(index), "]"))
    }
  }

def formatExtendedExpr(expr: ExtendedExpr)(using writer: Formatter): Unit =
  expr match {
    case Assert(expr) => {
      writer.print("assert ")
      formatBasicExpr(expr)
    }
    case MethodCall(name, args) => {
      writer.format("%s", name)
      formatBrackets("(", formatList(args, formatBasicExpr), ")")
    }
    case Let(left, right) => {
      writer.print("var ")
      left match {
        case Nil         => {}
        case head :: Nil => formatLValue(head)
        case lvalues     =>
          formatBrackets("(", formatList(lvalues, formatLValue), ")")
      }
      writer.print(" := ")
      formatBasicExpr(right)
    }
    case LetOrFail(left, leftType, right) => {
      writer.format("var %s", left)
      leftType.foreach(t => {
        writer.print(": ")
        formatType(t)
      })
      writer.print(" :| ")
      formatBasicExpr(right)
    }
  }

def formatExpr(expr: ExprBlock)(using writer: Formatter): Unit = {
  val ExprBlock(extendedExprs, basicExpr) = expr
  extendedExprs.foreach(expr => {
    formatExtendedExpr(expr)
    writer.println(";")
  })
  formatBasicExpr(basicExpr)
}

private def formatLValue(
    lvalue: (String, Option[Type])
)(using writer: Formatter): Unit = {
  val (varName, varType) = lvalue
  writer.format("%s", varName)
  varType.foreach(t => {
    writer.print(": ")
    formatType(t)
  })
}
