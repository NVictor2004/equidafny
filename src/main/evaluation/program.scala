package evaluation.program

import translation.structure.*
import evaluation.specification.evaluateSpec
import evaluation.statement.evaluateStatement
import evaluation.config.*

def evaluateProgram(program: Program): Double = ???

private def evaluateLemma(lemma: Lemma): Double = {

    // Ignore all but lemma specification and body
    // TODO: Could this be improved? 
    val Lemma(_, _, _, specs, body) = lemma

    LemmaCost + specs.map(evaluateSpec).sum + body.fold(0.0)(evaluateStatement)
}
