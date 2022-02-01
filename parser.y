%code requires{
#include "scanType.h"
}
%{
//Ryan Buckel
//CS445
//Bison parser
//The included vars from scanType are tokenClass, lineNum, tokenStr, cValue, nValue, sValue

#include <stdio.h>

#define YYERROR_VERBOSE
void yyerror (char const *s) {
   fprintf(stderr, "%s\n", s);
}

extern int yylex();
extern FILE *yyin;
//extern int lineNum;
//extern int numErrors;
%}

%union{
   TokenData *tokenData;
}

%token <tokenData> ID BOOLCONST CHARCONST NUMCONST STRINGCONST SYMB

%%

statements   : statements statement
             | statement
             ;

statement    : ID
             | BOOLCONST
             | NUMCONST
             | CHARCONST
             | STRINGCONST
             | SYMB
             ;

%%
extern int yydebug;
int main(int argc, char *argv[]){
   if(argc > 1){
      if(yyin = fopen(argv[1], "r")){
         //opened
      } else {
         printf("Failed to open file.\n");
      }
   }
   
   //numErrors = 0;
   //call parse
   yyparse();

   //printf("Number of errors: %d\n", numErrors);
   
   return 0;
}
