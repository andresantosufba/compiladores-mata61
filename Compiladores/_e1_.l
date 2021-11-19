/* 
 * Template para programa flex.
 * Autora: Christina von Flach
 */

%option noyywrap nodefault yylineno

%{
#include <stdlib.h>
#include "_e1_.tab.h"
#define DEBUG 0

%}

%%
"+" |
"-" |
";" |
"*" |
"/" |
"(" |
")" |
"=" {
	#if DEBUG
		printf("token com um caracter de valor %c na linha %d\n", yytext[0], yylineno);
	#endif 
	return yytext[0];}
"//".*                 { /* void */ }


"const"                 {
						#if DEBUG
							printf("token const na linha %d com valor %s\n", yylineno, yytext);
						#endif 
						return CONST; }
"int"                   { 
						#if DEBUG
							printf("token int na linha %d com valor %s\n", yylineno, yytext);
						#endif 
						return INT; }
"void"				    {
						#if DEBUG
							printf("token void na linha %d com valor %s\n", yylineno, yytext);
						#endif 
						return VOID; }
"return" 			    {
						#if DEBUG
							printf("token return na linha %d com valor %s\n", yylineno, yytext);
						#endif 
						return RETURN;}
[0-9]+                  {
						#if DEBUG
							printf("token NUM na linha %d com valor %d\n", yylineno, atoi(yytext));
						#endif
						yylval = atoi(yytext); return NUM; }

[a-zA-Z][a-zA-Z0-9_]*  { 
						#if DEBUG
							printf("token ID na linha %d com valor %s\n", yylineno, yytext);
						#endif
						return ID; }

"\n"                    {}
"\r"					{}
[ \n\t\r]+              {/*ignora quebra de linhas, tab e espaço*/  }


.                     { printf("Erro léxico na linha %d relacionado ao seguinte input %s\n",yylineno, yytext); } 

%%


/* Programa para simples conferência (ad-hoc) da saída yylex() */
/*
int main(int argc, char **argv) {
    int token;
    // TODO: ajustar para refletir os tokens declarados em e1.y
    //const int N = 6; // número de classes de tokens

    // Os nomes das classes de tokens de E1 estão em um array. 
    // Obs: só para mostrar o literal e tornar a saída mais clara.

    // TODO: o array token_name precisa ser ajustado ao incluir outros tokens
    char *token_name[] = {"CONST", "ID", "INT", "MINUS", "NUM", "PLUS"};

    while ((token = yylex())) {
       //fprintf(stdout,"token code: %d", token);
       
	   //fprintf(stdout,", token class: %s", token_name[token - 258]);
       //fprintf(stdout,", lexeme: %s\n", yytext);
	   printf("Linha número %d\n", yylineno);
    }
}
*/

