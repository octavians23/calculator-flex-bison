%option noyywrap

%{
#include <stdio.h>
#include <math.h>

 #define YY_DECL int yylex()

#include "exercise5.tab.h"

%}
%option noyywrap

%%

[ \t]	;
[0-9]+		{
    // rule for an integer number
    // convert the string to an integer
    yylval.ival = atoi(yytext); 
    return T_INT;}
[0-9]+"."[0-9]+  {
    // rule for a float number
    // convert the string to a float number
    yylval.fval = atof(yytext);
    return T_FLOAT;
}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLICATION;}
"/"		{return T_DIVISION;}
"^"		{return T_POWER;}
"("		{return T_LPARANTHESIS;}
")"		{return T_RPARANTHESIS;}

%%