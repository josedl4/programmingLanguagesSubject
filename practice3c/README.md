# ANTLR - Practice 3c.

## Description

Receive a correct class Java and make a tree of called methods with the objective the represent the method dependencies in test class.

## Execution instructions

* Compile antlr file: ~> `antlr4 -no-listener Java.g4`
* Compile java files generated: ~> `javac *.java`
* Execute: ~> `grun Java compilationUnit < [test file]  ( or -gui, -tree  ...)`

## Files:

* `Java.g4` Definition of Java grammar with antlr syntax.
* `Empleado.java` Test file with correct class Java.