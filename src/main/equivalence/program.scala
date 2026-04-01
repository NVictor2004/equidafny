package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeFunction

def programEquivalence(program: Program): Program = {
  given Program = program

  val data = program.candidateFunctions.map(
    functionEquivalence(program.modelFunction, _)
  )
  program.copy(
    mainLemmas = program.mainLemmas ++ data.map(_._1),
    helperLemmas = program.helperLemmas ++ data.flatMap(_._2)
  )
}

def functionEquivalence(
    model: Function,
    candidate: Function
)(using program: Program): (Lemma, List[Lemma], List[(String, String)]) = {
  val (helperLemmas, mapping, stmts) = mergeFunction(model, candidate)
  val mappingMap = mapping.map((a, b) => (b, a)).toMap

  val modelIdents = model.params.map(_.name)
  val candidateIdents = candidate.params.map(param => mappingMap(param.name))

  val modelMap = model.params.zip(modelIdents).map((p, i) => (p.name, Ident(i, Nil)))
  val candMap = candidate.params.zip(candidateIdents).map((p, i) => (p.name, Ident(i, Nil)))

  val equiv = Lemma(
    s"${model.name}_${candidate.name}_Equivalence",
    model.generic,
    model.params,
    model.specs ++
      List(
        Ensures(
          Binary(
            Eq,
            TrueFunctionCall(model.name, List(modelMap)),
            TrueFunctionCall(candidate.name, List(candMap))
          )
        )
      ),
    Some(BlockStmt(stmts))
  )
  (equiv, helperLemmas, mapping)
}
