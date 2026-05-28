package equivalence.expression

import translation.structure.*

import equivalence.program.{mergeFunction, generateLemmaName}
import equivalence.pattern.*
import scala.collection.immutable.ListMap
import scala.collection.mutable.Map as MutableMap

// Helper function to find the number of arguments in a function call
private def numberOfArguments[A, B](data: List[ListMap[A, B]]): Int = data.map(_.size).sum

// Merges two basic expressions together
// Returns statements to be put in the body of the equivalence lemma
def mergeBasicExpr(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: MutableMap[String, String], modelExpr: BasicExpr, modelFunc: Function, candExpr: BasicExpr, candFunc: Function)(using program: Program): List[Stmt] =
    (modelExpr, candExpr) match {
        // If both expressions call helper functions, merge the helper functions
        case (TrueFunctionCall(modelName, modelArgs), TrueFunctionCall(candName, candArgs))
        if modelName != candName && numberOfArguments(modelArgs) == numberOfArguments(candArgs) => {
            
            val mapping =
                if currentLemmas.get(modelName).isDefined then currentMappings
                else {
                    // This pair of functions has not been encountered yet, merge the functions themselves
                    val funcCalledInModel = program.helperFunctions(modelName)
                    val funcCalledInCand = program.helperFunctions(candName)
                    val (lemma, mapping) = mergeFunction(currentLemmas, funcCalledInModel, funcCalledInCand)
                    currentLemmas += lemma
                    mapping
                }

            // Convert mapping between the parameters of the called functions to a mapping between the arguments in the function calls
            // Merge these arguments together
            val stmts = mapping.map {
                case (candName, modelName) => candArgs(0)(candName) -> modelArgs(0)(modelName)
            }.flatMap((candExpr, modelExpr) => mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candFunc)).toList

            // Call the generated helper equivalence lemma
            val finalStmt = CallStmt(generateLemmaName(modelName, candName), List(modelArgs.flatMap(_.map(_._2))))

            stmts :+ finalStmt
        }
        // If both expressions call the same function, merge the arguments together
        case (OtherFunctionCall(calledInModel, calledInModelArgs), OtherFunctionCall(calledInCand, calledInCandArgs)) if calledInModel == calledInCand => {
            val flattened = calledInModelArgs.zip(calledInCandArgs).flatMap((modelList, candList) => modelList.zip(candList))
            flattened.flatMap((modelExpr, candExpr) => mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candFunc))
        }
        case (Cond(modelCond, modelThen, modelElse), Cond(candCond, candThen, candElse)) => {
            val condStmts = mergeBasicExpr(currentLemmas, currentMappings, modelCond, modelFunc, candCond, candFunc)
            val thenStmts = mergeExprBlock(currentLemmas, currentMappings, modelThen, modelFunc, candThen, candFunc)
            val elseStmts = mergeExprBlock(currentLemmas, currentMappings, modelElse, modelFunc, candElse, candFunc)

            // Only output an if expression if at least one of the branches is non-empty
            (thenStmts, elseStmts) match {
                case (Nil, Nil) => condStmts
                case _ => condStmts ++ List(CondStmt(modelCond, BlockStmt(thenStmts), Some(BlockStmt(elseStmts))))
            }
        }
        case (Tuple(modelElements), Tuple(candElements)) if modelElements.length == candElements.length =>
            modelElements.zip(candElements).flatMap((modelElem, candElem) => mergeBasicExpr(currentLemmas, currentMappings, modelElem, modelFunc, candElem, candFunc))
        
        case (Binary(modelOp, 
                     modelLeft @ TrueFunctionCall(_, modelLeftArgs), modelRight @ TrueFunctionCall(_, modelRightArgs)),
              Binary(candOp,
                     candLeft @ TrueFunctionCall(_, candLeftArgs), candRight @ TrueFunctionCall(_, candRightArgs)))
              if modelOp == candOp &&
                 numberOfArguments(modelLeftArgs) == numberOfArguments(candRightArgs) && 
                 numberOfArguments(modelRightArgs) == numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelLeftArgs) != numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelRightArgs) != numberOfArguments(candRightArgs) => {
            val leftStmts = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candRight, candFunc)
            val rightStmts = mergeBasicExpr(currentLemmas, currentMappings, modelRight, modelFunc, candLeft, candFunc)
            leftStmts ++ rightStmts
        }
        case (Binary(modelOp, modelLeft, modelRight), Binary(candOp, candLeft, candRight)) if modelOp == candOp => {
            val leftStmts = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candLeft, candFunc)
            val rightStmts = mergeBasicExpr(currentLemmas, currentMappings, modelRight, modelFunc, candRight, candFunc)
            leftStmts ++ rightStmts
        }
        case (Unary(modelOp, modelExpr), Unary(candOp, candExpr)) if modelOp == candOp => 
            mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candFunc)

        // Only create a mapping if merging two parameter identifiers
        case (Ident(modelName, Nil), Ident(candName, Nil)) => {
            if (modelFunc.params.isDefinedAt(modelName) && candFunc.params.isDefinedAt(candName)) {
                currentMappings += (candName -> modelName)
            }
            Nil
        }
        case (Match(modelExpr, modelCases), Match(candExpr, candCases)) => {
            // Merge the scrutinees together
            val exprStmts = mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candFunc)

            // For each case in the model match expression, find the cases in the candidate match expression
            // Where the patterns can be merged together
            // Merge the bodies of these cases together
            val finalMatchStmts = modelCases.map((modelPattern, modelBlock) => {
                val stmts = for {
                    (candPattern, candBlock) <- candCases
                    if mergePattern(modelPattern, candPattern)
                    stmt <- mergeExprBlock(currentLemmas, currentMappings, modelBlock, modelFunc, candBlock, candFunc)
                } yield stmt
                (modelPattern, stmts)
            })

            // Only output a match expression if at least one of the match case bodies is non-empty
            val allEmpty = finalMatchStmts.forall(_._2.isEmpty)
            if allEmpty then exprStmts else exprStmts :+ MatchStmt(modelExpr, finalMatchStmts)
        }
        case (Lambda(modelLvalues, modelBlock), Lambda(candLvalues, candBlock)) if modelLvalues.length == candLvalues.length =>
            mergeExprBlock(currentLemmas, currentMappings, modelBlock, modelFunc, candBlock, candFunc)
        case _ => Nil
    }

// Function to merge expression blocks
// Returns statements to be put in the body of the equivalence lemma
def mergeExprBlock(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: MutableMap[String, String], modelBlock: ExprBlock, modelFunc: Function, candBlock: ExprBlock, candFunc: Function)(using program: Program): List[Stmt] = {
    val ExprBlock(modelExtended, modelBasic) = modelBlock
    val ExprBlock(_, candBasic) = candBlock

    // Merge the basic expressions together
    val stmts = mergeBasicExpr(currentLemmas, currentMappings, modelBasic, modelFunc, candBasic, candFunc)

    // Always output any assertions or lemmas calls found in the model expression block
    val assertionsAndLemmaCalls = modelExtended.collect {
        case MethodCall(name, args) => CallStmt(name, List(args))
        case Assert(expr) => AssertStmt(expr)
    }

    // Only output the variable declarations if merging the basic expressions outputted statements
    val modelVariables = stmts match {
        case Nil => Nil
        case _ => modelExtended.collect {
            case Let(left, right) => LetStmt(left.map(_._1), right)
            case LetOrFail(left, _, right) => LetOrFailStmt(left, right)
        }
    }

    assertionsAndLemmaCalls ++ modelVariables ++ stmts
}
