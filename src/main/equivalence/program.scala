package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeFunction

def programEquivalence(program: Program): Program = {
  given Program = program

  val data = program.candidateFunctions.map(
    functionEquivalence(Map(), program.modelFunction, _)
  )
  program.copy(
    mainLemmas = program.mainLemmas ++ data.map(_._1._2),
    helperLemmas = program.helperLemmas ++ data.flatMap(_._2.values)
  )
}

def functionEquivalence(
    currentLemmas: Map[String, Lemma], 
    model: Function,
    candidate: Function
)(using program: Program): ((String, Lemma), Map[String, Lemma], List[(String, String)]) = {
  val (helperLemmas, mapping, stmts) = mergeFunction(currentLemmas, model, candidate)
  val mappingMap = mapping.map((a, b) => (b, a)).toMap

  val modelIdents = model.params.map(_.name)
  val candidateIdents = candidate.params.map(param => mappingMap(param.name))

  val modelMap = model.params.zip(modelIdents).map((p, i) => (p.name, Ident(i, Nil)))
  val candMap = candidate.params.zip(candidateIdents).map((p, i) => (p.name, Ident(i, Nil)))

  val modelFunctionCall = TrueFunctionCall(model.name, List(modelMap))
  val candFunctionCall = TrueFunctionCall(candidate.name, List(candMap))

  val (finalModelFunctionCall, finalCandFunctionCall) = program.normFunction match {
    case None => (modelFunctionCall, candFunctionCall)
    case Some(normFunction) => {
      val functionName = normFunction.name
      val lastParamName = normFunction.params.last.name
      (TrueFunctionCall(functionName, List(modelMap :+ (lastParamName, modelFunctionCall))), 
      TrueFunctionCall(functionName, List(candMap :+ (lastParamName, candFunctionCall))))
    }
  }
  

  val equiv = Lemma(
    s"${model.name}_${candidate.name}_Equivalence",
    model.generic,
    model.params,
    model.specs ++
      List(
        Ensures(
          Binary(
            Eq,
            finalModelFunctionCall,
            finalCandFunctionCall
          )
        )
      ),
    Some(BlockStmt(stmts))
  )
  ((model.name, equiv), helperLemmas, mapping)
}
