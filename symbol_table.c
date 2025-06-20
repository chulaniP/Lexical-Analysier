#include <stdio.h>
#include <string.h>
#include "symbol_table.h"
#include "sample5.tab.h"


// Static array to hold symbols
static Symbol symbols[MAX_SYMBOLS];
static int symbol_count = 0;

void insert_symbol(const char *lexeme, int token_type, int line_no) {
    // Check if symbol already exists (optional)
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbols[i].lexeme, lexeme) == 0 && symbols[i].line_no == line_no) {
            // Symbol already inserted for this line; do nothing or update if needed
            return;
        }
    }

    if (symbol_count < MAX_SYMBOLS) {
        strncpy(symbols[symbol_count].lexeme, lexeme, sizeof(symbols[symbol_count].lexeme) - 1);
        symbols[symbol_count].lexeme[sizeof(symbols[symbol_count].lexeme) - 1] = '\0';
        symbols[symbol_count].token_type = token_type;
        symbols[symbol_count].line_no = line_no;

        // Print inserted symbol info
        printf("Inserted: %s (Type: %s, Line: %d)\n",
               lexeme,
               token_type_to_string(token_type),
               line_no);

        symbol_count++;
    } else {
        fprintf(stderr, "Symbol table overflow!\n");
    }
}

// Helper function to convert token type to string
const char* token_type_to_string(int token_type) {
    switch(token_type) {
        case IF: return "IF";
        case ELSE: return "ELSE";
        case WHILE: return "WHILE";
        case RETURN: return "RETURN";
        case PRINT: return "PRINT";
        case IDENTIFIER: return "IDENTIFIER";
        case INTEGER: return "INTEGER";
        case FLOAT: return "FLOAT";
        case EQ: return "EQ";
        case LE: return "LE";
        case GE: return "GE";
        case NE: return "NE";
        case ASSIGN: return "ASSIGN";
        case LT: return "LT";
        case GT: return "GT";
        case PLUS: return "PLUS";
        case MINUS: return "MINUS";
        case MULT: return "MULT";
        case DIV: return "DIV";
        case LPAREN: return "LPAREN";
        case RPAREN: return "RPAREN";
        case LBRACE: return "LBRACE";
        case RBRACE: return "RBRACE";
        case SEMI: return "SEMI";
        case UNKNOWN: return "UNKNOWN";
        default: return "UNKNOWN_TOKEN";
    }
}

void print_symbol_table() {
    printf("\n[DEBUG] Entered print_symbol_table()\n");
    printf("Symbol Table:\n");
     printf("Lexeme\t\tType\t\tLine\n");
    printf("-------------------------------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%-10s\t%-10s\t%d\n",
               symbols[i].lexeme,
               token_type_to_string(symbols[i].token_type),
               symbols[i].line_no);
    }
}
