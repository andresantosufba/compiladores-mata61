/* 
 * Template de programa bison para a linguagem E1.
 * Serve apenas para definir tokens associados ao analisador léxico implentado com flex.
 * Executar  'bison -d e1.y' para gerar arquivos e1.tab.c e e1.tab.h.
 */

%{
/* includes, C defs */
#include "expr.h"
#define YYSTYPE struct expr *
struct expr * parser_result = 0;

#include <stdio.h>
#include <stdlib.h>

extern int yylineno;

void yyerror(const char* msg); 

int yylex();

%}

%locations
%define parse.error verbose

// TODO: adicionar outras classes de tokens de E1

/*
%union {
	int intval;
	char charval;
	double doubleval;
	char *strval;
	int subtok;
}
*/
/* declare tokens */
%token ID
%token INT
%token VOID
%token CONST
%token NUM
%token RETURN
/*%token return*/

%precedence RETURN
%precedence '='
%left '+' '-'
%left '*' '/'
%right '('

//%define api.value.type {int}



%start program

%%

program: declaration-list compound-stmt
;

declaration-list: declaration-list declaration |
declaration
;
declaration: var-declaration |
const-declaration
; 

var-declaration: type-specifier ID ';' 
;

type-specifier: INT | VOID;

const-declaration: CONST type-specifier ID '=' NUM ';'
;


compound-stmt: local-declarations statement-list
;

local-declarations: local-declarations var-declaration | %empty
;

statement-list: statement-list statement |
%empty
;

statement: expression-stmt |
return-stmt;

expression-stmt: expression ';' {$$ = $1;}| ';'
;

return-stmt: RETURN ';' {$$ = $2;}|
RETURN expression ';'	{$$ = $2;}
;

expression : ID '=' additive-expression;

additive-expression : additive-expression addop term { $$ = $2 == '+' ? expr_create(EXPR_ADD,$1,$3) : expr_create(EXPR_SUBTRACT,$1,$3) ;	}| 
term 
;

addop: '+' |
'-'
;

term : term mulop factor { switch((int)$2 ){
	case '*':
		$$ = expr_create(EXPR_MULTIPLY,$1,$3);
		break;
		
	case '/':
		if($3 != 0){
			$$ = expr_create(EXPR_DIVIDE,$1,$3);				
		}
		else{
			$$ = 0;			
		}
		break;
	}	
}|
factor {$$ = $1;}
;

mulop : '*' | '/'
;

factor : '('expression')' {$$ = $2;}
| ID 	{$$ = $1;}					
| NUM					
; 
//{ $$ = expr_create_value( atoi(expr_evaluate($1) ) );	}

%%
int main(void){
	//extern int yydebug;
	//yydebug = 1;
	int result;
	result = yyparse();
	if(result == 0)
		printf("Sucesso na realização da análise sintática.\n Retorno de yyparse() vale: %d\n", result);
	else{
		printf("Insucesso na realização da análise sintática.\n Retorno de yyparse() vale: %d\n", result);
	
	}
	
	return 0;
}

void yyerror(const char* msg){
    fprintf(stderr, "Linha do erro -> %d | mensagem de erro -> %s\n",yylineno,msg);
}


