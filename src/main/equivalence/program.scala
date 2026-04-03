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
    mainLemmas = program.mainLemmas ++ data.map(_._1._2.get),
    helperLemmas = program.helperLemmas ++ data.flatMap(_._2.values.map(_.get))
  )
}

def generateLemmaName(modelName: String, candName: String): String = 
  s"${modelName}_${candName}_Equivalence"

def functionEquivalence(
    currentLemmas: Map[String, Option[Lemma]], 
    model: Function,
    candidate: Function
)(using program: Program): ((String, Option[Lemma]), Map[String, Option[Lemma]], List[(String, String)]) = {
  val newLemma = (model.name, None)
  val (helperLemmas, mapping, stmts) = mergeFunction(currentLemmas + newLemma, model, candidate)
  val mappingMap = mapping.map((a, b) => (b, a)).toMap

  val modelIdents = model.params.map(_.name)
  val candidateIdents = candidate.params.map(param => mappingMap(param.name))

  val modelMap = model.params.zip(modelIdents).map((p, i) => (p.name, Ident(i, Nil)))
  val candMap = candidate.params.zip(candidateIdents).map((p, i) => (p.name, Ident(i, Nil)))

  val modelFunctionCall = TrueFunctionCall(model.name, List(modelMap))
  val candFunctionCall = TrueFunctionCall(candidate.name, List(candMap))

  val (finalModelFunctionCall, finalCandFunctionCall) = program.normFunction match {
    case Some(normFunction) if model.name == program.modelFunction.name => {
      val functionName = normFunction.name
      val lastParamName = normFunction.params.last.name
      (TrueFunctionCall(functionName, List(modelMap :+ (lastParamName, modelFunctionCall))), 
      TrueFunctionCall(functionName, List(candMap :+ (lastParamName, candFunctionCall))))
    }
    case _ => (modelFunctionCall, candFunctionCall)
  }
  

  val equiv = Lemma(
    generateLemmaName(model.name, candidate.name),
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
  ((model.name, Some(equiv)), helperLemmas - model.name, mapping)
}
