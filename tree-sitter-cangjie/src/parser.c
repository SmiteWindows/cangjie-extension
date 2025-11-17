// tree-sitter-cangjie/src/parser.c
#include <tree_sitter/parser.h>

enum TokenType {
  COMMENT,
  STRING,
  NUMBER,
  IDENTIFIER,
  BLOCK_COMMENT,
  LINE_COMMENT,
  FUNCTION,
  STRUCT,
  ENUM,
  INTERFACE,
  MODULE,
  IMPORT,
  LET,
  VAR,
  FN,
  PUB,
  TRUE,
  FALSE,
  IF,
  ELSE,
  FOR,
  WHILE,
  RETURN,
  BREAK,
  CONTINUE,
};

void *tree_sitter_cangjie_external_scanner_create() { return NULL; }
void tree_sitter_cangjie_external_scanner_destroy(void *p) {}
unsigned tree_sitter_cangjie_external_scanner_serialize(void *p, char *buffer) { return 0; }
void tree_sitter_cangjie_external_scanner_deserialize(void *p, const char *b, unsigned n) {}

bool tree_sitter_cangjie_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
  return false;
}

const TSLanguage *tree_sitter_cangjie(void) {
  static const TSLanguage language = {
    .version = LANGUAGE_VERSION,
    .symbol_count = 0,
    .alias_count = 0,
    .token_count = 0,
    .external_token_count = 0,
    .state_count = 0,
    .large_state_count = 0,
    .production_id_count = 0,
    .field_count = 0,
    .max_alias_sequence_length = 0,
    .parse_table = NULL,
    .small_parse_table = NULL,
    .small_parse_table_map = NULL,
    .parse_actions = NULL,
    .symbol_names = NULL,
    .symbol_metadata = NULL,
    .public_symbol_map = NULL,
    .alias_map = NULL,
    .alias_sequences = NULL,
    .lex_modes = NULL,
    .lex_fn = NULL,
    .keyword_lex_fn = NULL,
    .keyword_capture_token = 0,
    .external_scanner = {
      .symbol_map = NULL,
      .serialize = tree_sitter_cangjie_external_scanner_serialize,
      .deserialize = tree_sitter_cangjie_external_scanner_deserialize,
      .scan = tree_sitter_cangjie_external_scanner_scan,
      .create = tree_sitter_cangjie_external_scanner_create,
      .destroy = tree_sitter_cangjie_external_scanner_destroy,
    },
    .primary_state_ids = NULL,
  };
  return &language;
}
