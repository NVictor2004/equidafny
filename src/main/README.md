## EquiDafny source code

This directory contains EquiDafny's Scala source code. `Main.scala` contains EquiDafny's entry point. The purposes of the sub-directories are as follows:

- `parsers`: Contains the parsing component. This is used to parse the Dafny source code into a Scala data structure. This was implemented using the Parsley parser combinator library.
- `translation`: Contains the translation component. This is used to translate the data structure outputted by the parser into another data structure optimised for generating equivalence lemmas. In addition, it embeds all provided configuration data into the data structure so that the JSON configuration file is no longer needed. 
- `optimisation`: Contains the optimisation component. This is used to translate the bodies of the functions being processed into the same structure to allow the function merging algorithm to proceed.
- `equivalence`: Contains the lemma generation component. This is where the function merging algorithm is implemented to generate equivalence lemmas.
- `formatter`: Contains the formatting component. This is used to write the functions and lemmas to a file so that the Dafny verifier can verify the generated lemmas. 

Further details on the contents of each sub-directory can be found within the corresponding sub-directory.