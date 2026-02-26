package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

def programEquivalence(program: Program): Program = {
  val data = program.candidateFunctions.map(functionEquivalence(program.modelFunction, _))
  program.copy(mainLemmas = program.mainLemmas ++ data.map(_._1), helperLemmas = program.helperLemmas ++ data.flatMap(_._2))
}

private def functionEquivalence(model: Function, candidate: Function): (Lemma, List[Lemma]) = {
    // Generate empty equivalence lemma for now
    val equiv = Lemma(
        s"${candidate.name}Equivalence",
        candidate.generic,
        candidate.params,
        candidate.specs ++
        List(
            Ensures(
            Binary(
                Eq,
                FunctionCall(model.name, List(candidate.params.map(p => Ident(p.name, Nil)))),
                FunctionCall(candidate.name, List(candidate.params.map(p => Ident(p.name, Nil))))
            )
        )),
        Some(BlockStmt(Nil))
    )
    (equiv, Nil)
}