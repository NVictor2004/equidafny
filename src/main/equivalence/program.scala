package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeFunction
import equivalence.types.getListOfTypes

import scala.collection.mutable.Map as MutableMap

def programEquivalence(program: Program): Program = {
  given Program = program

  val data = program.candidateFunctions.map(candFunction => {
    val currentLemmas = MutableMap[String, Option[Lemma]]()
    val ((_, lemma), _) = functionEquivalence(currentLemmas, program.modelFunction, candFunction)
    (lemma, currentLemmas.values)
  })
  program.copy(
    mainLemmas = program.mainLemmas ++ data.map(_._1.get),
    helperLemmas = program.helperLemmas ++ data.flatMap(_._2.map(_.get))
  )
}

def generateLemmaName(modelName: String, candName: String): String = 
  s"${modelName}_${candName}_Equivalence"

// TODO: Check if original pair of functions have the same number of arguments
def functionEquivalence(
    currentLemmas: MutableMap[String, Option[Lemma]],
    model: Function,
    candidate: Function
)(using program: Program): ((String, Option[Lemma]), Map[String, String]) = {
  currentLemmas += (model.name -> None)
  val (mappingMap, stmts) = mergeFunction(currentLemmas, model, candidate)

  val modelIdents = model.params.keys
  val candidateIdents = candidate.params.map((paramName, _) => mappingMap(paramName))

  val modelMap = model.params.zip(modelIdents).map((p, i) => (p._1, Ident(i, Nil))).toList
  val candMap = candidate.params.zip(candidateIdents).map((p, i) => (p._1, Ident(i, Nil))).toList

  val (params, modelArgs, candArgs) = model.returnType match {
    case ArrowType(from, _) => {
      val types = getListOfTypes(from)
      val Lambda(lvalues, _) = model.body.basicExpr
      val idents = lvalues.map(_._1)
      val paramData = idents.zip(types)
      val argData = idents.map(ident => (ident, Ident(ident, Nil)))
      (model.params ++ paramData, List(modelMap, argData), List(candMap, argData))
    }
    case _ => (model.params, List(modelMap), List(candMap))
  }

  val modelFunctionCall = TrueFunctionCall(model.name, modelArgs)
  val candFunctionCall = TrueFunctionCall(candidate.name, candArgs)
  

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
    params,
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
  currentLemmas -= model.name
  ((model.name, Some(equiv)), mappingMap)
}
