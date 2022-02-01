%{
//Ryan Buckel
//CS445
//Lexer

//includes go here
#include <string.h>
#include "scanType.h"
#include "y.tab.h"

//main variables
int lineNum = 1;
int numErrors;

//any functions needed

static int tokenClassify(int line, int tokenClass, char *sVal){
   //init token data struct
   yylval.tokenData = new TokenData();

   yylval.tokenData->lineNum = line;
   yylval.tokenData->sValue = strdup(sVal);

   //check all classes
   if(tokenClass == ID){
      if(strcmp(sVal, "begin") == 0){
         printf("Line %d Token: BEGIN\n", line);
      }
      else if(strcmp(sVal, "int") == 0){
         printf("Line %d Token: INT\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "return") == 0){
         printf("Line %d Token: RETURN\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "end") == 0){
         printf("Line %d Token: END\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "if") == 0){
         printf("Line %d Token: IF\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "then") == 0){
         printf("Line %d Token: THEN\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "else") == 0){
         printf("Line %d Token: ELSE\n", line);
      } 
      else if(strcmp(yylval.tokenData->sValue, "bool") == 0){
         printf("Line %d Token: BOOL\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "char") == 0){
         printf("Line %d Token: CHAR\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "static") == 0){
         printf("Line %d Token: STATIC\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "and") == 0){
         printf("Line %d Token: AND\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "or") == 0){
         printf("Line %d Token: OR\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "not") == 0){
         printf("Line %d Token: NOT\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "while") == 0){
         printf("Line %d Token: WHILE\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "for") == 0){
         printf("Line %d Token: FOR\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "by") == 0){
         printf("Line %d Token: BY\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "to") == 0){
         printf("Line %d Token: TO\n", line);
      }
      else if(strcmp(yylval.tokenData->sValue, "break") == 0){
         printf("Line %d Token: BREAK\n", line);
      }

      else {
         printf("Line %d Token: ID Value: %s\n", line, yylval.tokenData->sValue);
      }
   }
   else if(tokenClass == NUMCONST){
      printf("Line %d Token: NUMCONST Value: %s  Input: %s\n", line, yylval.tokenData->sValue, yylval.tokenData->sValue);
   }
   else if(tokenClass == BOOLCONST){
      int boolean = 0;
      if(strcmp(sVal, "true") == 0){
         boolean = 1;
      } else {
         boolean = 0;
      }
      printf("Line %d Token: BOOLCONST Value: %d  Input: %s\n", line, boolean, yylval.tokenData->sValue);
   }
   else if(tokenClass == CHARCONST){
      if(strcmp(sVal, "\'\\n\'") == 0){
         yylval.tokenData->cValue = '\n';
      }
      else if(strcmp(sVal, "\'\\0\'") == 0){
         yylval.tokenData->cValue = '\0';
      }
      else if(strncmp(sVal, "\'\\", 2) == 0){
         yylval.tokenData->cValue = sVal[2];
      }
      else if(strlen(sVal) > 4){
         printf("WARNING(%d): character is %d characters long and not a single character: '%s'.  The first char will be used.\n", lineNum, strlen(sVal)-2, sVal);
         if(sVal[1] == '\\'){
            yylval.tokenData->cValue = sVal[2];
         } else {
            yylval.tokenData->cValue = sVal[1];
         }
      }
      else {
         if(strlen(sVal) > 3){
            printf("WARNING(%d): character is %d characters long and not a single character: '%s'.  The first char will be used.\n", lineNum, strlen(sVal)-2, sVal);
            yylval.tokenData->cValue = sVal[1];
         }
         else {
            yylval.tokenData->cValue = sVal[1];
         }
      }
      printf("Line %d Token: CHARCONST Value: '%c'  Input: %s\n", line, yylval.tokenData->cValue, yylval.tokenData->sValue);
   }
   else if(tokenClass == STRINGCONST){
      char outVal[strlen(sVal)];
      int shift = 0;
      int newLen = 0;
      for(int i = 0; i+shift < strlen(sVal); i++){
         if(sVal[i+shift] == '\\'){
            //Check following char
            if(sVal[i+1+shift] == 'n'){
               outVal[i] = '\n';
               shift++;
            } else {
               outVal[i] = sVal[i+1+shift];
               shift++;
            }
         } else {
            outVal[i] = sVal[i+shift];
         }
         newLen++;
      }
      char newVal[newLen+1];
      for(int i = 0; i < newLen; i++){
         newVal[i] = outVal[i];
      }
      newVal[newLen] = '\0';
      printf("Line %d Token: STRINGCONST Value: %s  Len: %d  Input: %s\n", line, newVal, strlen(newVal)-2, yylval.tokenData->sValue);
   }
   else if(tokenClass == SYMB){
      if(strcmp(sVal, "<-") == 0){
         printf("Line %d Token: ASGN\n", line);
      }
      else if(strcmp(sVal, "+=") == 0){
         printf("Line %d Token: ADDASGN\n", line);
      }
      else if(strcmp(sVal, "--") == 0){
         printf("Line %d Token: DEC\n", line);
      } 
      else if(strcmp(sVal, "!=") == 0){
         printf("Line %d Token: NEQ\n", line);
      }
      else if(strcmp(sVal, ">=") == 0){
         printf("Line %d Token: GEQ\n", line);
      }
      else if(strcmp(sVal, "<=") == 0){
         printf("Line %d Token: LEQ\n", line);
      }
      else if(strcmp(sVal, "++") == 0){
         printf("Line %d Token: INC\n", line);
      }
      else {
         printf("Line %d Token: %s\n", line, yylval.tokenData->sValue);
      }
   }

   return tokenClass;
}

%}

%option noyywrap

%%
[ \t\r]					;
[\n]								{lineNum++;}
true|false							{return tokenClassify(lineNum, BOOLCONST, yytext);}
\"(\\.|[^\\"\n])*\"						{return tokenClassify(lineNum, STRINGCONST, yytext);}
([A-Z]|[a-z])+([a-z]|[A-Z]|[0-9])*				{return tokenClassify(lineNum, ID, yytext);}
[0-9]+								{return tokenClassify(lineNum, NUMCONST, yytext);}
'\\n'|'\\0'|'.'|'..'|'([A-Z]|[a-z]|[0-9]|\ ([\ -\&]|[\(-~]))*'	{return tokenClassify(lineNum, CHARCONST, yytext);}
\-\-								{return tokenClassify(lineNum, SYMB, yytext);}
[\%]|[\(-\-]|[\/]|[\:-\?]|[\[\]]				{return tokenClassify(lineNum, SYMB, yytext);}
\<\-|\+\=|\>\=|\<\=|\!\=|\+\+					{return tokenClassify(lineNum, SYMB, yytext);}
\/\/.*\n							{lineNum++;}
##.*[\n\r]|[\r]							{lineNum++;}
.								{printf("ERROR(%d): Invalid or misplaced input character: '%s'. Character Ignored.\n", lineNum, yytext);}
%%
