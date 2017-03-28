%{  #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<math.h>

    //
    int top = -1;
    int *counterKeywords;
    char arrayKeyWords [50][15];
    
    //
    int exist = 0;
    int count = 0;
    int num = 0;
    FILE *fid;
    FILE *fnum;
    char *tmp;
    char buffer[15];
%}

let [a-zA-Z]
dig [0-9]
digs {dig}+
frac [.]{digs}
expo [eE][+-]?{digs}
id {let}({let}|{dig})*
num {digs}{frac}?{expo}?
keyword abstract|assert|boolean|break|byte|case|catch|char|class|const|continue|default|do|double|else|enum|extends|final|finally|float|for|goto|if|implements|import|instanceof|int|interface|long|native|new|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|transient|try|void|volatile|while

%%
\".*\" printf("Comillas");
\'.*\' printf("ComillasSimples");
"//".* printf("Comentario1");
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] printf("Comentario2");

{keyword}       {
                    printf("%s",yytext);
                    exist = 0;
                    for(int i = 0; i < top + 1; i++){
                        if(strncmp(yytext, arrayKeyWords[i], 15) == 0){
                            exist = 1;
                            counterKeywords[i] ++;
                        }
                    }
                    if(exist == 0){
                        top ++;
                        counterKeywords[top] = 1;
                        strcpy(arrayKeyWords[top], yytext);
                    }
                }
{id}        {
                printf("%s",yytext);
                exist = 0;
                count = 0;
                rewind(fid);

                while (fscanf(fid, "%s - %d\n", buffer, &num) != EOF){
                    int nDigits = (int)floor(log10(abs(num))) + 1;
                    count += strlen(buffer)+ nDigits + 4;
                    if(strcmp(buffer, yytext) == 0) {
                        fseek(fid, count - strlen(buffer) - nDigits - 4, SEEK_SET);
                        printf("%d", count);
                        fprintf(fid, "%s - %d\n", yytext, num+1);
                        exist = 1;
                    }
                }

                if(exist == 0){
                    fprintf(fid, "%s - %d\n", yytext, 1);
                }
            }
{num}       {
                printf("%s",yytext);
                exist = 0;
                count = 0;
                rewind(fnum);

                while (fscanf(fnum, "%s - %d\n", buffer, &num) != EOF){
                    int nDigits = (int)floor(log10(abs(num))) + 1;
                    count += strlen(buffer)+ nDigits + 4;
                    if(strcmp(buffer, yytext) == 0) {
                        fseek(fid, count-strlen(buffer) - nDigits - 4, SEEK_SET);
                        printf("%d", count);
                        fprintf(fnum, "%s - %d\n", yytext, num+1);
                        exist = 1;
                    }
                }

                if(exist == 0){
                    fprintf(fnum, "%s - %d\n", yytext, 1);
                }
            }

.           {printf("%s", yytext);}
%%

main( int argc, char** argv ) {
    counterKeywords = (int*) malloc(50*sizeof(int));
    
    FILE *f1 = fopen("identi.txt", "w");
    FILE *f2 = fopen("numero.txt", "w");
    fclose(f1);
    fclose(f2);

    fid = fopen("identi.txt", "r+");
    fnum = fopen("numero.txt", "r+");

    
    yyin = stdin;
    printf("---Entra---\n");
    yylex();
    printf("---Sale---\n");
    fclose(fid);
    fclose(fnum);
    
    FILE *fwr = fopen("reserv.txt", "w");
    for(int i = 0; i < top +1; i++){
        fprintf(fwr, "%s  \t -  %d\n", arrayKeyWords[i], counterKeywords[i]);
    }
    fclose(fwr);
    
}

