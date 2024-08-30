%{
#include <stdio.h>
#include <stdlib.h>

/* Fonction pour afficher les tokens */
void print_token(const char *type, const char *value) {
    printf("%s: %s\n", type, value);
}
%}

/* Déclarations des motifs pour les tokens */
SELECT   "SELECT"
FROM     "FROM"
WHERE    "WHERE"
INSERT   "INSERT"
INTO     "INTO"
VALUES   "VALUES"
UPDATE   "UPDATE"
SET      "SET"
DELETE   "DELETE"
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
NUMBER    [0-9]+
STRING    \'[^\']*\'
OPERATOR  [+\-*/=<>]
WS        [ \t]+
NEWLINE   \n
COMMENT   --.*

%% 

{SELECT}     { print_token("Mot du langage", yytext); }
{FROM}       { print_token("KEYWORD", yytext); }
{WHERE}      { print_token("KEYWORD", yytext); }
{INSERT}     { print_token("KEYWORD", yytext); }
{INTO}       { print_token("KEYWORD", yytext); }
{VALUES}     { print_token("KEYWORD", yytext); }
{UPDATE}     { print_token("KEYWORD", yytext); }
{SET}        { print_token("KEYWORD", yytext); }
{DELETE}     { print_token("KEYWORD", yytext); }
{IDENTIFIER} { print_token("IDENTIFIER", yytext); }
{NUMBER}     { print_token("NUMBER", yytext); }
{STRING}     { print_token("STRING", yytext); }
{OPERATOR}   { print_token("OPERATEUR", yytext); }
{WS}         { /* Ignorer les espaces et les tabulations */ }
{NEWLINE}    { print_token("NEWLINE", yytext); }
{COMMENT}    { /* Ignorer les commentaires */ }
.            { printf("MISMATCH: %s\n", yytext); }

%% 

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("fopen");
            return EXIT_FAILURE;
        }
        yyin = file;
    } else {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        return EXIT_FAILURE;
    }
    yylex();
    return EXIT_SUCCESS;
}

