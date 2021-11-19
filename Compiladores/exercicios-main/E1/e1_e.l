/* 
 * Template para programa flex.
 * Autora: Christina von Flach
 */

%option noyywrap nodefault yylineno

%{
#include "e1.tab.h"
%}

%%

"//".*                { /* void */ }

// TODO: adicionar padrões para outras palavras-chave de E1
const                 { return CONST; }
int                   { return INT; }


[0-9]+                { return NUM; }

[a-zA-Z][a-zA-Z0-9_]* { return ID; }

// TODO: adicionar padrões para outros síbolos de E1
"+"                   { return PLUS; }
"-"                   { return MINUS; }

[ \n\t]+              { /* void */ }

// TODO: reportar mensagem de erro e continuar
.                     { /* error */ } 

%%

/* Programa para simples conferência (ad-hoc) da saída yylex() */

int main(int argc, char **argv) {
    int token;

    // TODO: ajustar para refletir os tokens declarados em e1.y
    const int N = 6; // número de classes de tokens

    // Os nomes das classes de tokens de E1 estão em um array. 
    // Obs: só para mostrar o literal e tornar a saída mais clara.

    // TODO: o array token_name precisa ser ajustado ao incluir outros tokens
    char *token_name[N] = {"CONST", "ID", "INT", "MINUS", "NUM", "PLUS"};

    while ((token = yylex())) {
       fprintf(stdout,"token code: %d", token);
       fprintf(stdout,", token class: %s", token_name[token-258]);
       fprintf(stdout,", lexeme: %s\n", yytext);
    }
}


