#include "tree_sitter/parser.h"
#include <stdlib.h>
#include <string.h>

enum TokenType {
  MULTI_LINE_RAW_STRING_LITERAL,
  INDENT,
  DEDENT,
  NEWLINE
};

typedef struct {
  int hash_count;
  int indent_stack[100];
  int indent_stack_size;
  int current_indent;
  bool at_line_start;
} Scanner;

void *tree_sitter_cangjie_external_scanner_create() {
  Scanner *scanner = malloc(sizeof(Scanner));
  if (scanner) {
    scanner->hash_count = 0;
    scanner->indent_stack[0] = 0;
    scanner->indent_stack_size = 1;
    scanner->current_indent = 0;
    scanner->at_line_start = true;
  }
  return scanner;
}

void tree_sitter_cangjie_external_scanner_destroy(void *payload) {
  free(payload);
}

unsigned tree_sitter_cangjie_external_scanner_serialize(void *payload, char *buffer) {
  Scanner *scanner = (Scanner *)payload;
  unsigned offset = 0;
  
  // Serialize hash_count
  buffer[offset++] = scanner->hash_count;
  
  // Serialize indent_stack_size
  buffer[offset++] = scanner->indent_stack_size;
  
  // Serialize current_indent
  memcpy(buffer + offset, &scanner->current_indent, sizeof(scanner->current_indent));
  offset += sizeof(scanner->current_indent);
  
  // Serialize at_line_start
  buffer[offset++] = scanner->at_line_start;
  
  // Serialize indent_stack
  memcpy(buffer + offset, scanner->indent_stack, scanner->indent_stack_size * sizeof(int));
  offset += scanner->indent_stack_size * sizeof(int);
  
  return offset;
}

void tree_sitter_cangjie_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
  Scanner *scanner = (Scanner *)payload;
  unsigned offset = 0;
  
  if (length > 0) {
    // Deserialize hash_count
    scanner->hash_count = buffer[offset++];
  }
  
  if (length > offset) {
    // Deserialize indent_stack_size
    scanner->indent_stack_size = buffer[offset++];
  }
  
  if (length > offset + sizeof(scanner->current_indent)) {
    // Deserialize current_indent
    memcpy(&scanner->current_indent, buffer + offset, sizeof(scanner->current_indent));
    offset += sizeof(scanner->current_indent);
  }
  
  if (length > offset) {
    // Deserialize at_line_start
    scanner->at_line_start = buffer[offset++];
  }
  
  if (length > offset + scanner->indent_stack_size * sizeof(int)) {
    // Deserialize indent_stack
    memcpy(scanner->indent_stack, buffer + offset, scanner->indent_stack_size * sizeof(int));
  }
}

bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  Scanner *scanner = (Scanner *)payload;
  
  // Handle newline characters
  if (valid_symbols[NEWLINE] && (lexer->lookahead == '\n' || lexer->lookahead == '\r')) {
    lexer->result_symbol = NEWLINE;
    lexer->advance(lexer, false);
    if (lexer->lookahead == '\n' && lexer->get_column(lexer) == 0) {
      lexer->advance(lexer, false);
    }
    scanner->at_line_start = true;
    return true;
  }
  
  // Handle indentation at line start
  if (scanner->at_line_start && (valid_symbols[INDENT] || valid_symbols[DEDENT])) {
    // Skip any leading whitespace except newlines
    int indent = 0;
    while (lexer->lookahead == ' ' || lexer->lookahead == '\t') {
      if (lexer->lookahead == '\t') {
        indent += 4; // Convert tabs to 4 spaces
      } else {
        indent++;
      }
      lexer->advance(lexer, false);
    }
    
    // Skip comments and empty lines
    if (lexer->lookahead == '/' && lexer->get_column(lexer) == (uint32_t)indent) {
      // This is a comment, skip it
      scanner->at_line_start = false;
      return false;
    }
    
    if (lexer->lookahead == '\n' || lexer->lookahead == '\r' || lexer->lookahead == 0) {
      // This is an empty line, skip it
      scanner->at_line_start = false;
      return false;
    }
    
    int previous_indent = scanner->indent_stack[scanner->indent_stack_size - 1];
    
    if (indent > previous_indent && valid_symbols[INDENT]) {
      // Push the new indent to the stack
      scanner->indent_stack[scanner->indent_stack_size++] = indent;
      scanner->current_indent = indent;
      scanner->at_line_start = false;
      lexer->result_symbol = INDENT;
      return true;
    } else if (indent < previous_indent && valid_symbols[DEDENT]) {
      // Pop from the stack until we find the matching indent
      while (scanner->indent_stack_size > 1 && scanner->indent_stack[scanner->indent_stack_size - 1] > indent) {
        scanner->indent_stack_size--;
      }
      
      if (scanner->indent_stack[scanner->indent_stack_size - 1] == indent) {
        scanner->current_indent = indent;
        scanner->at_line_start = false;
        lexer->result_symbol = DEDENT;
        return true;
      }
    }
    
    scanner->current_indent = indent;
    scanner->at_line_start = false;
  }
  
  // Handle multi-line raw string literals
  if (valid_symbols[MULTI_LINE_RAW_STRING_LITERAL]) {
    // Count the number of leading '#' characters
    int hash_count = 0;
    while (lexer->lookahead == '#') {
      hash_count++;
      lexer->advance(lexer, false);
    }
    
    if (hash_count == 0) {
      return false;
    }
    
    // Check for opening quote
    if (lexer->lookahead != '"' && lexer->lookahead != '\'') {
      return false;
    }
    
    char quote = lexer->lookahead;
    lexer->advance(lexer, false);
    
    // Scan until we find the closing quote followed by the same number of '#'
    bool found_closing = false;
    while (lexer->lookahead != 0) {
      if (lexer->lookahead == quote) {
        // Found a quote, check if it's followed by the same number of '#'
        lexer->advance(lexer, false);
        
        int closing_hash_count = 0;
        while (lexer->lookahead == '#' && closing_hash_count < hash_count) {
          closing_hash_count++;
          lexer->advance(lexer, false);
        }
        
        if (closing_hash_count == hash_count) {
          found_closing = true;
          break;
        }
      } else {
        lexer->advance(lexer, false);
      }
    }
    
    if (found_closing) {
      lexer->result_symbol = MULTI_LINE_RAW_STRING_LITERAL;
      return true;
    }
  }
  
  scanner->at_line_start = false;
  return false;
}
