%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

//declare the union, to work with both int and float
%union {
	int ival;
	float fval;
}

// tokens declaration
%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS  T_MULTIPLICATION T_DIVISION T_POWER T_LPARANTHESIS T_RPARANTHESIS
%token T_NEWLINE

// precedence for the order of operations
%left T_PLUS T_MINUS
%left T_MULTIPLICATION T_DIVISION
%left NEGATIVE
%right T_POWER

// expresion for the integers
%type<ival> expression

// expresion for the float numbers
%type<fval> fexpression


%start calculation

%%

calculation:
	   | calculation line
;

// when a new line is found(enter is pressed) show the result of the operation
line: T_NEWLINE
    | expression T_NEWLINE { printf("\tResult: %i\n", $1); }
    | fexpression T_NEWLINE { printf("\tResult: %.2f\n", $1); }

;

// for operations with only integers
expression: T_INT				{ $$ = $1; }
    | expression T_PLUS expression	{ $$ = $1 + $3; }
    | expression T_MINUS expression	{ $$ = $1 - $3; }
    | expression T_MULTIPLICATION expression	{ $$ = $1 * $3; }
    | expression T_DIVISION expression	{ $$ = $1 / $3; }
    | expression T_POWER expression	{ $$ = pow($1,$3); }
    | T_MINUS expression %prec NEGATIVE { $$=-$2; }
    | T_LPARANTHESIS expression T_RPARANTHESIS { $$=$2; }
;

// for operations with floats and integers
// return a float number at the end of the operation
fexpression: T_FLOAT { $$ = $1; }
    
    //sum
    | fexpression T_PLUS fexpression { $$ = $1 + $3; }
    | fexpression T_PLUS expression { $$ = $1 + $3; }
    | expression T_PLUS fexpression { $$ = $1 + $3; }

    // substraction
    | fexpression T_MINUS fexpression	{ $$ = $1 - $3; }
    | expression T_MINUS fexpression	{ $$ = $1 - $3; }
    | fexpression T_MINUS expression	{ $$ = $1 - $3; }

    // multiplication
    | fexpression T_MULTIPLICATION fexpression	{ $$ = $1 * $3; }
    | expression T_MULTIPLICATION fexpression	{ $$ = $1 * $3; }
    | fexpression T_MULTIPLICATION expression	{ $$ = $1 * $3; }

    // division 
    | fexpression T_DIVISION fexpression	{ $$ = $1 / $3; }
    | expression T_DIVISION fexpression	{ $$ = $1 / $3; }
    | fexpression T_DIVISION expression	{ $$ = $1 / $3; }

    // power 
    | fexpression T_POWER fexpression	{ $$ = pow($1,$3); }
    | expression T_POWER fexpression	{ $$ = pow($1,$3); }
    | fexpression T_POWER expression	{ $$ = pow($1,$3); }

    // negative number
    | T_MINUS fexpression %prec NEGATIVE { $$=-$2; }

    // paranthesis
    | T_LPARANTHESIS fexpression T_RPARANTHESIS { $$=$2; }
    
%%


int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
