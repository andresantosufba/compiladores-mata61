#include "expr.h"
#include<stdlib.h>
#include<stdio.h>

struct expr *expr_create( expr_t kind, struct expr *left,struct expr *right ){
	struct expr *e = malloc(sizeof(*e));
	e->kind = kind;
	e->value = 0;
	e->left = left;
	e->right = right;
	return e;
}
struct expr *expr_create_value( int value ){
	struct expr *e = expr_create(EXPR_VALUE,0,0);
	e->value = value;
	return e;
}

int expr_evaluate( struct expr *e ){
	if(!e) return 0;
	
	int l = expr_evaluate(e->left);
	int r = expr_evaluate(e->right);
	
	switch(e->kind) {
		case EXPR_VALUE: return e->value;
		case EXPR_ADD: return l+r;
		case EXPR_SUBTRACT: return l - r;
		case EXPR_MULTIPLY: return l * r;
		case EXPR_DIVIDE:
		if(r==0) {
			printf("runtime error: divide by zero\n");
			exit(1);
		}
		return l/r;
	}
	return 0;
}

void expr_print( struct expr *e ){
	if(!e) return;
	printf("(");
	expr_print(e->left);
	switch(e->kind) {
		case EXPR_VALUE: printf("%d",e->value); break;
		case EXPR_ADD: printf("+"); break;
		case EXPR_SUBTRACT: printf("-"); break;
		case EXPR_MULTIPLY: printf("*"); break;
		case EXPR_DIVIDE: printf("/"); break;
	}
	expr_print(e->right);
	printf(")");
}
/*
int main(){
	struct expr *a = expr_create_value(10);
	struct expr *b = expr_create_value(20);
	struct expr *c = expr_create(EXPR_ADD,a,b);
	struct expr *d = expr_create_value(30);
	struct expr *e = expr_create(EXPR_MULTIPLY,c,d);
	expr_print(e);	
	
	struct expr *z = expr_create(EXPR_MULTIPLY,
					expr_create(EXPR_ADD,expr_create_value(20),expr_create_value(30)),
					expr_create_value(50)
				);
	int ab = expr_evaluate(z);
	
	printf("A variável ab vale %d\n", ab);
	
}
*/