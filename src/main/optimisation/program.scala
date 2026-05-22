package optimisation.program

import translation.structure.*

import optimisation.expression.optimiseExprBlock

def optimiseProgram(program: Program): Program = {
    val Program(
        _, _, modelFunction, candidateFunctions, helperFunctions, _, _, _, _, _
    ) = program
    
    program.copy(
        modelFunction = optimiseFunction(modelFunction),
        candidateFunctions = candidateFunctions.map(optimiseFunction),
        helperFunctions = helperFunctions.map((name, func) => (name, optimiseFunction(func))).toMap
    )
}

private def optimiseFunction(func: Function): Function = 
    func.copy(body = optimiseExprBlock(func.body))
