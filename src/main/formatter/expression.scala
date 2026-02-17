package formatter.expression

import scala.annotation.tailrec

import translation.structure.*
import translation.structure.BinaryOperator.*
import formatter.program.Formatter
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

@tailrec
def formatBasicExprList(exprs: List[BasicExpr])(using writer: Formatter): Unit =
  exprs match {
    case Nil          => {}
    case head :: Nil  => formatBasicExpr(head)
    case head :: tail => {
      formatBasicExpr(head)
      writer.print(", ")
      formatBasicExprList(tail)
    }
  }

private def formatOperator(operator: BinaryOperator): String =
  operator match {
    case Iff         => "<==>"
    case LeftImplies => "<=="
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
    case LeftShift     => "<<"
    case RightShift     => ">>"
    case Add           => "+"
    case Sub           => "-"
    case Mul           => "*"
    case Div           => "/"
    case Mod           => "%"
    case BitOr         => "|"
    case BitAnd        => "&"
    case BitXor        => "^"
  }

def formatBasicExpr(expr: BasicExpr)(using writer: Formatter): Unit =
  expr match {
    case expr: LiteralExpr => formatLiteral(expr)
    case Binary(operator, left, right) => {
      formatBasicExpr(left)
      writer.print(s" ${formatOperator(operator)} ")
      formatBasicExpr(right)
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
      varType.foreach(t => {
        writer.print(": ")
        formatType(t)
      })
      writer.print(" :: ")
      formatBasicExpr(body)
    }
    case Exists(variable, varType, body) => {
      writer.format("exists %s", variable)
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
    case Cardinality(e) => {
      writer.print("|")
      formatBasicExpr(e)
      writer.print("|")
    }
    case Tuple(es) => {
      writer.print("(")
      formatBasicExprList(es)
      writer.print(")")
    }
    case Brackets(e) => {
      writer.print("(")
      formatBasicExpr(e)
      writer.print(")")
    }
    case Cond(cond, thenBranch, elseBranch) => {
      writer.print("if ")
      formatBasicExpr(cond)
      writer.print(" then ")
      formatExpr(thenBranch)
      writer.print(" else ")
      formatExpr(elseBranch)
    }
    case FunctionCall(name, args) => {
      writer.format("%s", name)
      args.foreach(argList => {
        writer.print("(")
        formatBasicExprList(argList)
        writer.print(")")
      })
    }
    case LambdaCall(lambda, args) => {
      writer.print("(")
      formatBasicExpr(lambda)
      writer.print(")")
      writer.print("(")
      formatBasicExprList(args)
      writer.print(")")
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
    case Set(es) => {
      writer.print("{")
      formatBasicExprList(es)
      writer.print("}")
    }
    case Seq(es) => {
      writer.print("[")
      formatBasicExprList(es)
      writer.print("]")
    }
    case Lambda(lvalues, body) => {
      writer.print("(")
      lvalues match {
        case Nil          => {}
        case head :: tail => {
          val (varName, varType) = head
          writer.format("%s", varName)
          varType.foreach(t => {
            writer.print(": ")
            formatType(t)
          })
          tail.foreach((varName, varType) => {
            writer.print(", ")
            writer.format("%s", varName)
            varType.foreach(t => {
              writer.print(": ")
              formatType(t)
            })
          })
        }
      }
      writer.print(") => ")
      formatExpr(body)
    }
    case SeqIndex(name, indexes) => {
      writer.format("%s", name)
      indexes.foreach(index => {
        writer.print("[")
        formatIndex(index)
        writer.print("]")
      })
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
      writer.print("(")
      formatBasicExprList(args)
      writer.print(")")
    }
    case Let(left, right) => {
      writer.print("var ")
      left match {
        case Nil         => {}
        case head :: Nil => {
          val (varName, varType) = head
          writer.format("%s", varName)
          varType.foreach(t => {
            writer.print(": ")
            formatType(t)
          })
        }
        case head :: tail => {
          writer.print("(")
          val (varName, varType) = head
          writer.format("%s", varName)
          varType.foreach(t => {
            writer.print(": ")
            formatType(t)
          })
          tail.foreach((varName, varType) => {
            writer.print(", ")
            writer.format("%s", varName)
            varType.foreach(t => {
              writer.print(": ")
              formatType(t)
            })
          })
          writer.print(")")
        }
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
