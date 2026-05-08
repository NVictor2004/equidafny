package equivalence.program

import translation.structure.*
import translation.structure.BinaryOperator.*

import equivalence.expression.mergeExprBlock
import equivalence.types.getListOfTypes

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
  // Find Type mappings
  val modelTypeCounts = mapTypesToCounts(model.params)
  val candTypeCounts = mapTypesToCounts(candidate.params)

  val typeMappings = modelTypeCounts.foldLeft(List[(String, String)]()) {
      case (accMappings, (modelType, modelCount)) => {
          val candType = program.typeFunctions.get(modelType) match {
            case None => modelType
            case Some(func) => func.returnType
          }
          val candCount = candTypeCounts.getOrElse(candType, 0)
          if (modelCount != candCount) {
              throw new IllegalArgumentException("Types can't be matched")
          }
          if (modelCount == 1) {
              val modelName = model.params.find((_, currentType) => currentType == modelType).get._1
              val candName = candidate.params.find((_, currentType) => currentType == candType).get._1
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
      val (candName, _) = candParamsLeft.find((_, currentType) => currentType == program.typeFunctions.get(modelType).fold(modelType)(_.returnType)).get
      candParamsLeft = candParamsLeft.removed(candName)
      (candName, modelName)
  })

  // Append remaining mappings and convert to immutable Map
  currentMappings ++= remainingMappings
  val mapping = currentMappings.toMap

  val modelIdents = model.params.keys
  val candidateIdents = candidate.params.keys.map(paramName => mapping(paramName))

  val modelMap = ListMap(model.params.zip(modelIdents).map((p, i) => (p._1, Ident(i, Nil))).toList*)
  val candMap = ListMap(candidate.params.zip(candidateIdents).map((p, i) => (p._1, Ident(i, Nil))).toList*)

  val (params, modelArgs, candArgs) = getArgData(model.params, List(modelMap), List(candMap), model.returnType, model.body.basicExpr)

  val modelFunctionCall = TrueFunctionCall(model.name, modelArgs)
  val candFunctionCall = TrueFunctionCall(candidate.name, candArgs)

  val (finalModelFunctionCall, finalCandFunctionCall) = program.normFunction match {
    case Some(normFunction) if model.name == program.modelFunction.name => {
      val functionName = normFunction.name
      val lastParamName = normFunction.params.last._1
      (TrueFunctionCall(functionName, List(modelMap + (lastParamName -> modelFunctionCall))), 
      TrueFunctionCall(functionName, List(modelMap + (lastParamName -> candFunctionCall))))
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

private def mapTypesToCounts(params: ListMap[String, Type]): Map[Type, Int] = 
    params.foldLeft(MutableMap[Type, Int]()) {
        case (accMap, (_, paramType)) => {
            val count = accMap.getOrElse(paramType, 0)
            accMap += (paramType -> (count + 1))
        }
    }.toMap
