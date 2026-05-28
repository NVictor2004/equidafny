package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeExprBlock
import equivalence.types.{getListOfTypes, compatibleTypes}

import scala.collection.immutable.ListMap
import scala.collection.mutable.Map as MutableMap
import scala.annotation.tailrec

// Main function to generate equivalence lemmas
// Takes in original Program and outputs a new Program
// containing the equivalence lemmas
def programEquivalence(program: Program): Program = {
  val modelNumberOfArgs = program.modelFunction.params.size

  // The model and candidate functions must have the same number of parameters
  // If any candidate function has a different number of parameters
  // EquiDafny throws an error
  program.candidateFunctions.find(_.params.size != modelNumberOfArgs).foreach(candFunc =>
    throw IllegalArgumentException(s"Functions ${program.modelFunction.name} and ${candFunc.name} must have the same number of arguments")
  )

  // Generate equivalence lemmas
  given Program = program
  val data = program.candidateFunctions.map(candFunction => {
    val currentLemmas = MutableMap[String, Option[Lemma]]()
    val ((_, lemma), _) = mergeFunction(currentLemmas, program.modelFunction, candFunction)
    (lemma, currentLemmas.values)
  })

  // Output final Program
  program.copy(
    mainLemmas = program.mainLemmas ++ data.map(_._1.get),
    helperLemmas = program.helperLemmas ++ data.flatMap(_._2.map(_.get))
  )
}

// Helper function to generate equivalence lemma names
// This ensures names are generated consistently
def generateLemmaName(modelName: String, candName: String): String = 
  s"${modelName}_${candName}_Equivalence"

// Function to merge two functions together
// Returns the equivalence lemma and the mapping between the functions' parameters
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
  val remainingMappings = modelParamsLeft.map((modelName, modelType) => {
      val typeFunctionsList = program.typeFunctions.toList

      // Find a candidate parameter with a compatible type
      // Prioritise parameters with the same name as the model parameter
      // As these are more likely to be the correct parameter to map to 
      val candName = candParamsLeft.foldLeft(Option.empty[String]) {
        case (_, (candName, candType)) if modelName == candName && compatibleTypes(modelType, candType, typeFunctionsList) => Some(candName)
        case (None, (candName, candType)) if compatibleTypes(modelType, candType, typeFunctionsList) => Some(candName)
        case (currentName, _) => currentName
      }.get
      
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

// Helper function to deal with recursively defined lambda functions
// Outputs an extended list of lemma parameters
// and the arguments for the function calls in the lemma's postcondition
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
