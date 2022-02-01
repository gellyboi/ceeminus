#ifndef SCANTYPE_H
#define SCANTYPE_H

struct TokenData{
   int tokenClass;   //classification of token
   int lineNum;      //line that token was found on
   char *tokenStr;   //the string that was read
   char cValue;      //potential character value
   int nValue;       //value of number (probably from atoi?)
   char *sValue;     //for string literals or string type (char* too?)
};

#endif
