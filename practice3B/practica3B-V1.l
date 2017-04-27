%{
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  //guarda el estado de la tabla de prediccion
  int estado=0;
  //temporales para el tipo y el identificador del metodo
  String tmptype;
  String tmpid;
%}

let [a-zA-Z]
dig [0-9]
digs {dig}+
frac [.]{digs}
expo [eE][+-]?{digs}
id {let}({let}|{dig})*
num {digs}{frac}?{expo}?
keyword abstract|assert|boolean|break|byte|case|catch|char|class|const|continue|default|do|double|else|enum|extends|final|finally|float|for|goto|if|implements|import|instanceof|int|interface|long|native|new|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|transient|try|void|volatile|while

access public|private|protected
nonaccess final|static|synchronized|native|strictfp
class [A-Z][a-zA-Z]*
primitive boolean|byte|char|double|float|int|long|short|void
id [a-z]([a-zA-Z]|[0-9])*

%%
\".*\" printf("Comillas");
\'.*\' printf("ComillasSimples");
"//".* printf("Comentario1");
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] printf("Comentario2");

{access}  {
              if(estado==0){
                estado=1;
              }
              if(estado!=0){
                printf("error");
              }
}
{nonaccess} {
              if(estado<=2){
                estado=2;
              }else{
                printf("error");
              }

}
{class} {
              if(estado<=2){
                estado=3;
                tmptype=yytext;
              }else{
                printf("error");
              }
}
{primitive} {
              if(estado<=2){
                estado=3;
                tmptype=yytext;
              }else{
                printf("error");
              }
}
{id}  {
              if(estado==3 | estado ==4){
                estado=5;
              }else if(estado==8){
                estado=9;
              }
}
