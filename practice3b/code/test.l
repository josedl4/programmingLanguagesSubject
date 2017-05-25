%{  #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    /*

    

    */
%}

let [a-zA-Z]
dig [0-9]
digs {dig}+
frac [.]{digs}
expo [eE][+-]?{digs}
id ({let}|_({let}|{dig}|[_]))({let}|{dig}|[_])*
num {digs}{frac}?{expo}?[f]?
keyword abstract|assert|boolean|break|byte|case|catch|char|class|const|continue|default|do|double|else|enum|extends|final|finally|float|for|goto|if|implements|import|instanceof|int|interface|long|native|new|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|transient|try|void|volatile|while

basicsTypes boolean|byte|char|double|float|int|long|short|void
methodType ({basicsTypes}|([A-Z]{let}*))
accessModifier public|package|private
nonAccessModifier final|static|synchronized|native|strictfp

%%

[ \t\n]   ;
\".*\" printf("Comillas");
\'.*\' printf("ComillasSimples");
"//".* printf("Comentario1");
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] printf("Comentario2");
[^{digs}] printf("Esto NO es un digito");
[{digs}] printf("Esto SI es un digito");
