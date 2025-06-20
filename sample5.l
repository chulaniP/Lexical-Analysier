%{
#include <stdio.h>
#include "sample5.tab.h"      // Token definitions from Yacc
#include "symbol_table.h"    // Your symbol table functions

int line_no = 1;
%}

%%
"if"        { insert_symbol(yytext, IF, line_no); return IF; }
"else"      { insert_symbol(yytext, ELSE, line_no); return ELSE; }
"while"     { insert_symbol(yytext, WHILE, line_no); return WHILE; }
"return"    { insert_symbol(yytext, RETURN, line_no); return RETURN; }
"print"     { insert_symbol(yytext, PRINT, line_no); return PRINT; }

[a-zA-Z_][a-zA-Z0-9_]*    { insert_symbol(yytext, IDENTIFIER, line_no); return IDENTIFIER; }

[0-9]+\.[0-9]+            { insert_symbol(yytext, FLOAT, line_no); return FLOAT; }
[0-9]+                    { insert_symbol(yytext, INTEGER, line_no); return INTEGER; }

"=="    { insert_symbol(yytext, EQ, line_no); return EQ; }
"<="    { insert_symbol(yytext, LE, line_no); return LE; }
">="    { insert_symbol(yytext, GE, line_no); return GE; }
"!="    { insert_symbol(yytext, NE, line_no); return NE; }
"="     { insert_symbol(yytext, ASSIGN, line_no); return ASSIGN; }
"<"     { insert_symbol(yytext, LT, line_no); return LT; }
">"     { insert_symbol(yytext, GT, line_no); return GT; }
"+"     { insert_symbol(yytext, PLUS, line_no); return PLUS; }
"-"     { insert_symbol(yytext, MINUS, line_no); return MINUS; }
"*"     { insert_symbol(yytext, MULT, line_no); return MULT; }
"/"     { insert_symbol(yytext, DIV, line_no); return DIV; }

"("     { insert_symbol(yytext, LPAREN, line_no); return LPAREN; }
")"     { insert_symbol(yytext, RPAREN, line_no); return RPAREN; }
"{"     { insert_symbol(yytext, LBRACE, line_no); return LBRACE; }
"}"     { insert_symbol(yytext, RBRACE, line_no); return RBRACE; }
";"     { insert_symbol(yytext, SEMI, line_no); return SEMI; }

"//".*                               { /* skip single-line comment */ }
"/*"([^*]|\*+[^*/])*\*+"/"           { /* skip multi-line comment */ }

[ \t]+      { /* skip whitespace */ }
\n          { line_no++; }

.           { fprintf(stderr, "Unknown character '%s' at line %d\n", yytext, line_no); return UNKNOWN; }

%%

int yywrap() {
    return 1;
}
