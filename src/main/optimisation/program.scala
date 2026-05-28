package optimisation.program

import translation.structure.*

import optimisation.expression.optimiseExprBlock

// Main function to optimise a Program
// Only the model, candidate and helper functions are optimised
def optimiseProgram(program: Program): Program = {
    val Program(
        _, _, modelFunction, candFunctions, helperFunctions, _, _, _, _, _
    ) = program
    
    program.copy(
        modelFunction = optimiseFunction(modelFunction),
        candFunctions = candFunctions.map(optimiseFunction),
        helperFunctions = helperFunctions.map((name, func) => (name, optimiseFunction(func))).toMap
    )
}

// Function to optimise a function
// Only the body of the function is optimised
private def optimiseFunction(func: Function): Function = 
    func.copy(body = optimiseExprBlock(func.body))
