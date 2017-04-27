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
              }else if(estado==11){
                  //el estado sigue siendo 11

              }else{
                printf("error");
              }
}
{nonaccess} {
              if(estado<=2){
                estado=2;
              }else if(estado==11){
                  //el estado sigue siendo 11

              }else{
                printf("error");
              }

}
{class} {
              if(estado<=2){
                estado=3;
                tmptype=yytext;
              }else if(estado==6){
                estado=8;
              }else if(estado==10){
                estado=8;
              }else if(estado==11){
                  //el estado sigue siendo 11

              }else{
                printf("error");
              }
}
{primitive} {
              if(estado<=2){
                estado=3;
                tmptype=yytext;
              }else if(estado==6){
                estado=8;
              }else if(estado==10){
                estado=8;
              }else if(estado==11){
                  //el estado sigue siendo 11

              }else{
                printf("error");
              }
}
{id}  {
              if(estado==3 | estado ==4){
                estado=5;
              }else if(estado==8){
                estado=9;
              }else if(estado==11){
                //el estado sigue siendo 11
              }else{
                printf("error");
              }
}
[\[]  {
              if(estado==3){
                //el estado sigue siedo 3
              }else if(estado==8){
                //el estado sigue siendo 8
              }else{
                printf("error");
              }
}
[\]]  {
              if(estado==11){
                //el estado sigue siendo 11
              }else{
                printf("error");
              }
}
[\,]  {
              if(estado==9){
                estado=10;
              }else if(estado==11){
                //el estado sigue siendo 11
              }else{
                printf("error");
              }
}
[\(]  {
              if(estado==5){
                estado=6;
              }else if(estado==11){
                //el estado sigue igual
              }else{
                printf("error");
              }
}
[\)]  {
              if(estado==6 | estado==9){
                estado=7;
              }else if(estado==11){
                //el estado sigue siendo 11
              }else{
                printf("error");
              }
}
[\{]  {
              if(estado==7){
                estado=11;
              }else if(estado==11){
                //el estado sigue siendo 11
              }else{
                printf("error");
              }
}
[\}]  {
              if(estado==11){
                printf("%s  %s\n",tmpid,tmptype);
              }else{
                printf("error");
              }
}
