package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeExprBlock
import equivalence.types.{getListOfTypes, compatibleTypes}

import scala.collection.immutable.ListMap
import scala.collection.mutable.Map as MutableMap
import scala.annotation.tailrec

def programEquivalence(program: Program): Program = {
  given Program = program

  val data = program.candidateFunctions.map(candFunction => {
    val currentLemmas = MutableMap[String, Option[Lemma]]()
    val ((_, lemma), _) = mergeFunction(currentLemmas, program.modelFunction, candFunction)
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
def mergeFunction(
    currentLemmas: MutableMap[String, Option[Lemma]],
    model: Function,
    candidate: Function
)(using program: Program): ((String, Option[Lemma]), Map[String, String]) = {
  // Create mapping for the equivalence lemma currently being generated
  currentLemmas += (model.name -> None)

  // Mappings are generated through merging the function bodies and through type matching

  var candLeft = candidate.params

  // Generate type mappings
  val typeMappings = model.params.foldLeft(List[(String, String)]()) {
      case (accMappings, (modelName, modelType)) => {
        val typeFunctionsList = program.typeFunctions.toList
        val compatibleParams = candLeft.filter((_, candType) => compatibleTypes(modelType, candType, typeFunctionsList)).toList
        if (compatibleParams.isEmpty) {
          throw IllegalArgumentException(
            s"Parameter types of functions ${model.name} and ${candidate.name} can't be matched"
          )
        }
        if (compatibleParams.length == 1) {
          val candName = compatibleParams(0)._1
          candLeft = candLeft.removed(candName)
          (candName, modelName) :: accMappings
        } else {
          accMappings
        }
      }
  }

  val currentMappings = MutableMap(typeMappings*)

  // Merge the function bodies
  // This will append further mappings and create the body of the equivalence lemma
  val stmts = mergeExprBlock(currentLemmas, currentMappings, model.body, model, candidate.body, candidate)

  // Find parameters not covered already
  val modelParamsLeft = model.params.removedAll(currentMappings.values)
  var candParamsLeft = candidate.params.removedAll(currentMappings.keys)

  // Generate remaining mappings
  // TODO: Check for compatible types here
  val remainingMappings = modelParamsLeft.map((modelName, modelType) => {
      val candType = program.typeFunctions.get(modelType).fold(modelType)(_.returnType)
      val (candName, _) = candParamsLeft.find((_, currentType) => currentType == candType).get
      candParamsLeft = candParamsLeft.removed(candName)
      (candName, modelName)
  })

  // Append remaining mappings and convert to immutable Map
  currentMappings ++= remainingMappings
  val mapping = currentMappings.toMap

  // Create mappings from parameter names to arguments
  // These will be used to create the function calls in the lemma's postcondition
  val modelMap = ListMap(model.params.map((name, _) => (name, Ident(name, Nil))).toList*)
  val candMap = ListMap(candidate.params.map((candName, candType) => {
    // The argument can either be an identifier or a function call if a type transformation is needed
    val modelName = mapping(candName)
    val modelType = model.params(modelName)
    val ident = Ident(modelName, Nil)
    // If a type transformation is needed, construct the corresponding function call
    // Otherwise, return an identifier
    val finalArg = program.typeFunctions.get(modelType) match {
      case Some(typeFunc) if typeFunc.returnType == candType => {
        val paramName = typeFunc.params.keys.head
        TrueFunctionCall(typeFunc.name, List(ListMap(paramName -> ident)))
      }
      case _ => ident
    }
    (candName, finalArg)
  }).toList*)

  // Create further lemma parameters and function call arguments when the model and candidate functions
  // output lambda functions
  val (params, modelArgs, candArgs) = getArgData(model.params, List(modelMap), List(candMap), model.returnType, model.body.basicExpr)

  // Create the function calls to be used in the lemma's postcondition
  val modelFunctionCall = TrueFunctionCall(model.name, modelArgs)
  val candFunctionCall = TrueFunctionCall(candidate.name, candArgs)

  // Use the normalisation function if provided
  // Only use it on the original model and candidate functions, not on any helper functions
  val (finalModelFunctionCall, finalCandFunctionCall) = program.normFunction match {
    case Some(normFunction) if model.name == program.modelFunction.name => {
      val functionName = normFunction.name
      val lastParamName = normFunction.params.last._1
      (TrueFunctionCall(functionName, List(modelMap + (lastParamName -> modelFunctionCall))), 
      TrueFunctionCall(functionName, List(modelMap + (lastParamName -> candFunctionCall))))
    }
    case _ => (modelFunctionCall, candFunctionCall)
  }

  // Create the equivalence lemma
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

  // Remove the mapping for the current equivalence lemma since it has finished generating
  currentLemmas -= model.name

  ((model.name, Some(equiv)), mapping)
}

@tailrec
private def getArgData(params: ListMap[String, Type], modelMap: List[ListMap[String, BasicExpr]], candMap: List[ListMap[String, BasicExpr]], t: Type, expr: BasicExpr): (ListMap[String, Type], List[ListMap[String, BasicExpr]], List[ListMap[String, BasicExpr]]) = t match {
  case ArrowType(from, to) => {
      val types = getListOfTypes(from)
      val Lambda(lvalues, body) = expr
      val idents = lvalues.map(_._1)
      val paramData = idents.zip(types)
      val argData = ListMap(idents.map(ident => (ident, Ident(ident, Nil)))*)
      getArgData(params ++ paramData, modelMap :+ argData, candMap :+ argData, to, body.basicExpr)
    }
    case _ => (params, modelMap, candMap)
}
