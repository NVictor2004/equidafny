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

// TODO: Check if original pair of functions have the same number of arguments
def functionEquivalence(
    currentLemmas: Map[String, Option[Lemma]], 
    model: Function,
    candidate: Function
)(using program: Program): ((String, Option[Lemma]), Map[String, Option[Lemma]], Map[String, String]) = {
  val newLemma = (model.name, None)
  val (helperLemmas, mappingMap, stmts) = mergeFunction(currentLemmas + newLemma, model, candidate)

  val modelIdents = model.params.keys
  val candidateIdents = candidate.params.map((paramName, _) => mappingMap(paramName))

  val modelMap = model.params.zip(modelIdents).map((p, i) => (p._1, Ident(i, Nil))).toList
  val candMap = candidate.params.zip(candidateIdents).map((p, i) => (p._1, Ident(i, Nil))).toList

  val modelFunctionCall = TrueFunctionCall(model.name, List(modelMap))
  val candFunctionCall = TrueFunctionCall(candidate.name, List(candMap))

  val (finalModelFunctionCall, finalCandFunctionCall) = program.normFunction match {
    case Some(normFunction) if model.name == program.modelFunction.name => {
      val functionName = normFunction.name
      val lastParamName = normFunction.params.last._1
      (TrueFunctionCall(functionName, List(modelMap :+ (lastParamName, modelFunctionCall))), 
      TrueFunctionCall(functionName, List(modelMap :+ (lastParamName, candFunctionCall))))
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
  ((model.name, Some(equiv)), helperLemmas - model.name, mappingMap)
}
