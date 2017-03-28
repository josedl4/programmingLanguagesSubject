%{  #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<math.h>

    //
    int topKW = -1;
    int *counterKeywords;
    char arrayKeyWords [50][15];

    int topID = -1;
    int lenID = 50;
    int *counterIDs;
    char **arrayIDs;

    int topNUM = -1;
    int lenNUM = 50;
    int *counterNumbers;
    char **arrayNumbers;
    
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
"//".* printf("Comentario1");
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] printf("Comentario2");

{keyword}       {
                    printf("%s",yytext);
                    exist = 0;
                    for(int i = 0; i < topKW + 1; i++){
                        if(strncmp(yytext, arrayKeyWords[i], 15) == 0){
                            exist = 1;
                            counterKeywords[i] ++;
                            break;
                        }
                    }
                    if(exist == 0){
                        topKW ++;
                        counterKeywords[topKW] = 1;
                        strcpy(arrayKeyWords[topKW], yytext);
                    }
                }
{id}        {
                printf("%s",yytext);
                exist = 0;

                if(lenID == (topID + 1)){
                    //printf("mas memoria /%d div %d/ - %d\n", sizeof(counterIDs), sizeof(int), topID);
                    if((counterIDs = (int *)realloc(counterIDs, sizeof(int)*lenID*2)) == NULL){
                        printf("unable to allocate memory\n");
                        exit -1;
                    }
                    
                    if((arrayIDs = realloc(arrayIDs, sizeof(char*)*lenID*2))==NULL){
                        printf("unable to allocate memory\n");
                        exit -1;
                    }
                    
                    for(int i = lenID; i < lenID*2; i++){
                        if((arrayIDs[i] = malloc(sizeof(char)*240)) == NULL){
                            printf("unable to allocate memory\n");
                            exit -1;
                        }
                    }
                    lenID = lenID * 2;
                }

                for(int i = 0; i < topID + 1; i++){
                    if(strncmp(yytext, arrayIDs[i], 240) == 0){
                        exist = 1;
                        counterIDs[i] ++;
                        break;
                    }
                }
                if(exist == 0){
                    topID ++;
                    counterIDs[topID] = 1;
                    strcpy(arrayIDs[topID], yytext);
                }

                //printf("TOP = %d; LENID = %d\n", topID, lenID);
            }
{num}       {
                printf("%s",yytext);
                exist = 0;

                if(lenNUM == (topNUM + 1)){
                    //printf("mas memoria /%d div %d/ - %d\n", sizeof(counterIDs), sizeof(int), topID);
                    if((counterNumbers = (int *)realloc(counterNumbers, sizeof(int)*lenNUM*2)) == NULL){
                        printf("unable to allocate memory\n");
                        exit -1;
                    }
                    
                    arrayNumbers = realloc(arrayNumbers, sizeof(char*)*lenNUM*2);
                    
                    for(int i = lenNUM; i < lenNUM*2; i++){
                        if((arrayNumbers[i] = malloc(sizeof(char)*240)) == NULL){
                            printf("unable to allocate memory\n");
                            exit -1;
                        }
                    }
                    lenNUM = lenNUM * 2;
                }

                for(int i = 0; i < topNUM + 1; i++){
                    if(strncmp(yytext, arrayNumbers[i], 240) == 0){
                        exist = 1;
                        counterNumbers[i] ++;
                        break;
                    }
                }
                if(exist == 0){
                    topNUM ++;
                    counterNumbers[topID] = 1;
                    strcpy(arrayNumbers[topID], yytext);
                }

                if(topNUM == 49) printf("Aquiii\n");
            }

.           {printf("%s", yytext);}
%%

main( int argc, char** argv ) {
    counterKeywords = (int *) malloc(50*sizeof(int));
    counterIDs = (int *) malloc(50*sizeof(int));
    counterNumbers = (int *) malloc(50*sizeof(int));

    arrayIDs = (char **) malloc(50*sizeof(char*));
    arrayNumbers = (char **) malloc(50*sizeof(char*));

    for(int i = 0; i < 50; i ++){
        if((arrayIDs[i] = malloc(sizeof(char) * 240)) == NULL){
            printf("unable to allocate memory\n");
            exit -1;
        }
        if((arrayNumbers[i] = malloc(sizeof(char) * 240)) == NULL){
            printf("unable to allocate memory\n");
            exit -1;
        }
    }
    

    
    yyin = stdin;
    printf("---Entra---\n");
    yylex();
    printf("---Sale---\n");
    fclose(fid);
    fclose(fnum);
    
    FILE *fwr = fopen("reserv.txt", "w");
    for(int i = 0; i < topKW +1; i++){
        fprintf(fwr, "%s  \t -  %d\n", arrayKeyWords[i], counterKeywords[i]);
    }
    fclose(fwr);

    FILE *fid = fopen("identi.txt", "w");
    fclose(fid);
    FILE *fnum = fopen("numero.txt", "w");
    fclose(fnum);
    
}

