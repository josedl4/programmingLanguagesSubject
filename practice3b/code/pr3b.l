%{  #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>

    int state = 0;
    FILE *f;
    char methodName [50];
    char methodType [50]; 

    int ppt [12][12] = 
    { 1,  2,  3,  3, -1, -1, -1, -1, -1, -1, -1, -1,        // 0
     -1,  2,  3,  3, -1, -1, -1, -1, -1, -1, -1, -1,        // 1
     -1,  2,  3,  3, -1, -1, -1, -1, -1, -1, -1, -1,        // 2
     -1, -1, -1, -1,  5,  3, -1, -1, -1, -1, -1, -1,        // 3
     -1, -1, -1, -1,  5, -1, -1, -1, -1, -1, -1, -1,        // 4
     -1, -1, -1, -1, -1, -1, -1,  6, -1, -1, -1, -1,        // 5
     -1, -1,  8,  8, -1, -1, -1, -1,  7, -1, -1, -1,        // 6
     -1, -1, -1, -1, -1, -1, -1, -1, -1, 11, -1, -1,        // 7
     -1, -1, -1, -1,  9,  8, -1, -1, -1, -1, -1, -1,        // 8
     -1, -1, -1, -1, -1, -1, 10, -1,  7, -1, -1, -1,        // 9
     -1, -1,  8,  8, -1, -1, -1, -1, -1, -1, -1, -1,        // 10
     11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 11 };      // 11

    int pair (int input, char* text){
        int tmp = state;
        if(ppt[tmp][input] != -1) {
            state = ppt[tmp][input];
            //printf("State Update: %d / Input: %d\n", state, input);
        } else {
            state = 0;
            return -1;
        }

        if(input == 3 && (state == 3))
            strcpy(methodType, text);

        if(input == 4 && (state == 5))
            strcpy(methodName, text);

        if(state == 12){
            fprintf(f, "Name - %10s  |  Type - %10s\n", methodName, methodType);
            state = 0;
        }

        return 0;
    }

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
[ \t\n]     ;
\".*\"      ;
\'.*\'      ;
"//".*      ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]     ;

{accessModifier}        {   //printf("log: Access Modifier - %s\n", yytext); 
                            if(pair(0, yytext) == -1) pair(0, yytext);}
{nonAccessModifier}     {   //printf("log: Non Access Modifier - %s\n", yytext); 
                            if(pair(1, yytext) == -1) pair(1, yytext);}
{methodType}            {   //printf("log: Method Type - %s\n", yytext);
                            //strcpy(methodType, yytext);
                            if(pair(3, yytext) == -1) pair(3, yytext);}
"["[ \t]*"]"            {   //printf("log: Character [] - %s\n", yytext); 
                            if(pair(5, yytext) == -1) pair(5, yytext);}
{id}                    {   //printf("log: Identifier - %s\n", yytext); 
                            //strcpy(methodName, yytext);
                            if(pair(4, yytext) == -1) pair(4, yytext);}
"("                     {   //printf("log: Character ( - %s\n", yytext); 
                            if(pair(7, yytext) == -1) pair(7, yytext);}
")"                     {   //printf("log: Character ) - %s\n", yytext); 
                            if(pair(8, yytext) == -1) pair(8, yytext);}
","                     {   //printf("log: Character , - %s\n", yytext); 
                            if(pair(6, yytext) == -1) pair(6, yytext);}
"{"                     {   //printf("log: Character { - %s\n", yytext); 
                            if(pair(9, yytext) == -1) pair(9, yytext);}
"}"                     {   //printf("log: Character } - %s\n", yytext); 
                            if(pair(10, yytext) == -1) pair(10, yytext);}

.                       {   //printf("log: Other character - %s\n", yytext); 
                            pair(11, yytext);}

%%

int main( int argc, char** argv ) {

    if ( argc > 1 ){
        if((yyin = fopen( argv[1], "r" )) == NULL){
            printf("File not found\n");
            exit(-1);
        }
    } else {
        yyin = stdin;
    }

    f = fopen("method.txt", "w");
    fprintf(f, "\tMetodos del archivo Java:\n");
    fprintf(f, "\t#########################\n");

    yylex();

    fclose(f);
}