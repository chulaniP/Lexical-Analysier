#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

// Maximum size of the symbol table
#define MAX_SYMBOLS 1000

// Structure to hold symbol information
typedef struct {
    char lexeme[64];  // token text
    int token_type;   // token type (e.g. IDENTIFIER, INTEGER, PRINT)
    int line_no;      // line number where token appeared
} Symbol;

// Insert a symbol into the symbol table
void insert_symbol(const char *lexeme, int token_type, int line_no);

// Print all symbols in the table
void print_symbol_table();

const char* token_type_to_string(int token_type);

#endif // SYMBOL_TABLE_H


