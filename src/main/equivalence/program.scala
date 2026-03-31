package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

// import equivalence.expression.convertExprBlock
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
)(using program: Program): (Lemma, List[Lemma], List[(Int, Int)]) = {

  val (helperLemmas, mapping, stmts) = mergeFunction(model, candidate)

  val modelIdents = model.params.map(p => Ident(p.name, Nil))

  val candidateIdents = if (mapping.length == modelIdents.length) then mapping.sortBy(_._2).map {
    case (modelIndex, _) => modelIdents(modelIndex)
  } else modelIdents

  val equiv = Lemma(
    s"${candidate.name}Equivalence",
    model.generic,
    model.params,
    model.specs ++
      List(
        Ensures(
          Binary(
            Eq,
            FunctionCall(
              model.name,
              List(modelIdents)
            ),
            FunctionCall(
              candidate.name,
              List(candidateIdents)
            )
          )
        )
      ),
    Some(BlockStmt(stmts))
  )
  (equiv, helperLemmas, mapping)
}
