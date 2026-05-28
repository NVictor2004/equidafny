# EquiDafny source code

This directory contains EquiDafny's Scala source code. `Main.scala` contains EquiDafny's entry point. The purposes of the sub-directories are as follows:

- `parsers`: Contains the parsing component. This is used to parse the Dafny source code into a Scala data structure. This was implemented using the Parsley parser combinator library.
    - `parsers/structure`: Contains the definition of the data structure outputted by the parser. This structure is only used within the parser component. 
- `translation`: Contains the translation component. This is used to translate the data structure outputted by the parser into another data structure optimised for generating equivalence lemmas. In addition, it embeds all provided configuration data into the data structure so that the JSON configuration file is no longer needed. 
    - `translation/structure`: Contains the definition of the optimised data structure outputted by the translation component. This structure will be used in all future components. 
- `optimisation`: Contains the optimisation component. This is used to translate the bodies of the functions being processed into the same structure to allow the function merging algorithm to proceed.
- `equivalence`: Contains the lemma generation component. This is where the function merging algorithm is implemented to generate equivalence lemmas.
- `formatter`: Contains the formatting component. This is used to write the functions and lemmas to a file so that the Dafny verifier can verify the generated lemmas. 

## Data structure categories

Each of the two data structures (defined in `parsers/structure` and `translation/structure` respectively) are defined in 7 categories. The purposes of these categories are as follows:

- `expression`: Contains the definition of a Dafny expression. Expressions are primarily used in function bodies (lemma bodies contain statements instead). Expressions include literals, binary operators and more complex structures including lambda functions and match expressions. 
- `index`: Contains definitions for the different ways to manipulate data in Dafny sequences.
- `pattern`: Contains definitions for the different types of patterns that can be used in match expressions and statements.
- `program`: Contains definitions for the top-level structures, including datatype declarations, lemmas and functions. 
- `specification`: Contains definitions for specifications including preconditions, postconditions and variants. 
- `statement`: Contains the definition of a Dafny statement. Statements are only used in lemma bodies. These include match statements and variable declarations.
- `type`: Contains definitions for the different types that can be used in a Dafny program. 

## Sub-directory structure

Each sub-directory is split into several files. The majority of these files are each named after one of the 7 data structure categories and contains all code relating to that category. For example, `formatter/expression` contains the code for writing expressions to a file. 