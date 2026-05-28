import org.scalatest.flatspec.AnyFlatSpec

import parsers.structure.*

import parsers.program.program

class ParsersTest extends AnyFlatSpec {
  val datatype = "datatype List<T> = Nil | Cons(head: T, tail: List<T>)"
  val function = """function add_horn_1(i: int, j: int): int
    requires (i >= 0)
  {
    if (i == 0) then j
    else add_horn_1(i-1, j+1)
  }
  """

  val ghostfunction = s"ghost $function"
  val lemma = """lemma equivalenceFunnyZip(xs: List<int>, ys: List<int>)
    ensures (funnyZip1(xs, ys) == funnyZipM(xs, ys))
  {
    match (xs, ys)
      case (Cons(x, _), Cons(y, _)) => equivalenceChoose(x, y);
      case _ =>
  }"""

  "A datatype" should "be parsed correctly" in {
    val output = program.parse(datatype)
    assert(
      output.get == List(
        Datatype(
          "List",
          Some(List(("T", None))),
          List(
            DeclaredType("Nil", None),
            DeclaredType(
              "Cons",
              Some(
                List(
                  Parameter("head", NamedType("T", None)),
                  Parameter(
                    "tail",
                    NamedType("List", Some(List(NamedType("T", None))))
                  )
                )
              )
            )
          )
        )
      )
    )
  }

  "A function" should "be parsed correctly" in {
    val output = program.parse(function)
    assert(
      output.get == List(
        Function(
          "add_horn_1",
          None,
          List(Parameter("i", TypeInt), Parameter("j", TypeInt)),
          TypeInt,
          List(
            Requires(
              GTE(
                Ident("i", Nil),
                IntLiteral(0)
              )
            )
          ),
          ExprBlock(
            Nil,
            Cond(
              Eq(
                Ident("i", Nil),
                IntLiteral(0)
              ),
              ExprBlock(Nil, Ident("j", Nil)),
              ExprBlock(
                Nil,
                FunctionCall(
                  "add_horn_1",
                  List(
                    List(
                      Sub(
                        Ident("i", Nil),
                        IntLiteral(1)
                      ),
                      Add(
                        Ident("j", Nil),
                        IntLiteral(1)
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  }

  "A ghost function" should "be parsed correctly" in {
    val output = program.parse(ghostfunction)
    assert(
      output.get == List(
        GhostFunction(
          "add_horn_1",
          None,
          List(Parameter("i", TypeInt), Parameter("j", TypeInt)),
          TypeInt,
          List(
            Requires(
              GTE(
                Ident("i", Nil),
                IntLiteral(0)
              )
            )
          ),
          ExprBlock(
            Nil,
            Cond(
              Eq(
                Ident("i", Nil),
                IntLiteral(0)
              ),
              ExprBlock(Nil, Ident("j", Nil)),
              ExprBlock(
                Nil,
                FunctionCall(
                  "add_horn_1",
                  List(
                    List(
                      Sub(
                        Ident("i", Nil),
                        IntLiteral(1)
                      ),
                      Add(
                        Ident("j", Nil),
                        IntLiteral(1)
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  }

  "A lemma" should "be parsed correctly" in {
    val output = program.parse(lemma)
    assert(
      output.get == List(
        Lemma(
          "equivalenceFunnyZip",
          None,
          List(
            Parameter("xs", NamedType("List", Some(List(TypeInt)))),
            Parameter("ys", NamedType("List", Some(List(TypeInt))))
          ),
          List(
            Ensures(
              Eq(
                FunctionCall(
                  "funnyZip1",
                  List(
                    List(
                      Ident("xs", Nil),
                      Ident("ys", Nil)
                    )
                  )
                ),
                FunctionCall(
                  "funnyZipM",
                  List(
                    List(
                      Ident("xs", Nil),
                      Ident("ys", Nil)
                    )
                  )
                )
              )
            )
          ),
          Some(
            BlockStmt(
              List(
                MatchStmt(
                  Tuple(List(Ident("xs", Nil), Ident("ys", Nil))),
                  List(
                    (
                      PatternTuple(
                        List(
                          Basic("Cons", Some(List(Basic("x", None), UnNamed))),
                          Basic("Cons", Some(List(Basic("y", None), UnNamed)))
                        )
                      ),
                      List(
                        CallStmt(
                          "equivalenceChoose",
                          List(Ident("x", Nil), Ident("y", Nil))
                        )
                      )
                    ),
                    (UnNamed, Nil)
                  )
                )
              )
            )
          )
        )
      )
    )
  }
}
