%{
#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

int yylex();
void yyerror(const char *s);
%}

%token IF ELSE WHILE RETURN PRINT
%token IDENTIFIER INTEGER FLOAT
%token EQ LE GE NE ASSIGN LT GT PLUS MINUS MULT DIV
%token LPAREN RPAREN LBRACE RBRACE SEMI UNKNOWN

%%

program:
    statements
    ;

statements:
    statements statement
    | statement
    ;

statement:
    expression SEMI           { printf("Statement OK\n"); }
    | PRINT expression SEMI   { printf("Print statement OK\n"); }
    | error SEMI              { yyerror("Syntax error"); yyerrok; }
    ;

expression:
    IDENTIFIER ASSIGN expression
    | expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | LPAREN expression RPAREN
    | IDENTIFIER
    | INTEGER
    | FLOAT
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Starting parsing...\n");
    int parse_result = yyparse();
    printf("Parsing finished with code: %d\n", parse_result);
    if (parse_result == 0) {
        printf("Parsing completed successfully.\n");
        print_symbol_table();
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}
