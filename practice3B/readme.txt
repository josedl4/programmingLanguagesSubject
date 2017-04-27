#####--COSAS UTILES--#####
Package para atom, highlight de sintaxis lex/flex para atom:
https://atom.io/packages/language-lex-flex-new
BNF Index of JAVA language grammar:
http://cui.unige.ch/isi/bnf/JAVA/BNFindex.html
Codigo ejemplo parser LL(1):
http://www.cplusplus.com/forum/beginner/46712/


####--COSAS A TENER EN CUENTA--####
Los tipos que se definan comienzan desde 258,
se reservan los números anteriores para carácteres ascii.
ej:
#define INTEGER 258
#define CHAR 259
#define NUM 260
#define OF 261
#define PTPT 262
#define ARRAY 263

El analizador debe ser descendente recursivo basado en gramática LL(1)
LL(1)=  entrada por la izquierda,
        se deriva lo que esté más a la izquierda,
        se predice símbolo a símbolo.

Documentación de métodos en java:
https://docs.oracle.com/javase/tutorial/java/javaOO/methods.html

La declaración de métodos y funciones tiene 6 componentes:
1- Modificadores (public, private, etc.)
2-Tipo de salida (void, int , char, etc.)
3-Nombre del método
4-Lista de parametros entre paréntesis, separados por comas o vacío en caso de no tener paŕametros
5-Lista de excepciones (throws IOException, IndexOutOfBoundsException,etc.)
6-El código del método entre llaves {// CODIGO //}

/// FACTORIZACION ///

Mododifiers-Doc:https://docs.oracle.com/javase/tutorial/reflect/member/methodModifiers.html
Modificador-> (public | private | protected)(final | abstract | synchronized)(native | strictfp)

TipoDeSalida-> (primitive | class | void )
primitive-Doc: https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html
primitive->(byte | short | int |long | float | double | char | string | boolean)

ParametrosEntrada-> (((primitive | class )identificador)(([,] (primitive | class))identificador)*) | ε
