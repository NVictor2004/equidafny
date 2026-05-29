# EquiDafny's tests

EquiDafny's tests are split between two main files. `parsers.scala` contains a few simple tests to check that the parser works correctly. `examplesTest.scala` contains the vast majority of EquiDafny's tests. The tests created in this file are defined below.

## Equivalence Tests

To create these tests, I wrote a JSON configuration file for each file in my dataset of equivalence tests. These JSON files are within the `json` directory. These files are organised in sub-directories based on where these tests originated from. These sub-directories are further split into directories based on what challenges the Dafny verifier faces when it attempts to prove equivalence. This allowed me to control testing according to which challenges I had addressed. For each JSON file, all components in EquiDafny's main pipeline are executed in order (Parsing, Translation, Optimisation, Lemma Generation and Formatting). The final output file is stored in the appropriate sub-directory in the `output` directory.

After this, if I have addressed all the challenges within this test, the Dafny verifier is executed to verify the generated equivalence lemmas. If I have not addressed all the challenges, the Dafny verifier only checks that the outputted file is syntactically and semantically valid.