# Exercício 2 (individual)

Implemente um analisador sintático chamado de "_e1_"
para a linguagem [E1](#aspectos-sintaticos), usando a ferramenta Bison.
O analisador sintático deve trabalhar em conjunto com o analisador léxico desenvolvido no exercício 1 com a ferramenta Flex (arquivo _e1.l_).

Considere os arquivos _e1.l_ e _e1.y_ como ponto de partida para resolver este exercício.

__Atenção__: utilizar o arquivo _e1.l_ criado e já testado no exercício 1 (E1).
O arquivo _e1.y_ desta pasta está incompleto e deve ser modificado
para incorporar as regras gramaticais da linguagem especificada a seguir.

## Aspectos Sintáticos

```
<program> ::= <declaration-list> <compound-stmt>

<declaration-list> ::= <declaration-list> <declaration> | <declaration>

<declaration> ::= <var-declaration> | <const-declaration>

<var-declaration> ::= <type-specifier> ID ;

<type-specifier> ::= INT | VOID

<const-declaration> ::= CONST <type-specifier> ID = NUM ;

```

```
<compound-stmt> ::= <local-declarations> <statement-list>

<local-declarations> ::= <local-declarations> <var-declaration> | empty

<statement-list> ::= <statement-list> <statement> | empty

<statement> ::= <expression-stmt> | <return-stmt>

<expression-stmt> ::= <expression> ; | ;

<return-stmt> ::= return ; | return <expression> ;

```

```
<expression> ::= ID = <additive-expression>

<additive-expression> ::= <additive-expression> <addop> <term> | <term>

<addop ::= + | -

<term> ::= <term> <mulop> <factor> | <factor>

<mulop> ::= * | /

<factor> ::= ( <expression> ) | ID | NUM

```

-----
Adaptação com base no material cedido pelo Prof. Vinicius Petrucci.

## Exemplo de um programa na linguagem E1

```
// exemplo.e1
// programa na linguagem E1 sem erros léxicos nem sintáticos
// palavras-chave: const int return void
// simbolos: +  -  *  /  =  ;   (  )

    int a_bar;
    const int b = 25;
    int c;
    int q1;

    a_bar = 40;
    c = b*b + a_bar;

    return q1 = c / (c-a);
```

## Execução e teste

```
bison -d e1.y
flex e1.l
cc -o e1 lex.yy.c e1.tab.c
./e1 < exemplo.e1
```
gcc -o e1 lex.yy.c e1.tab.c

## Saída esperada

Reportar:
- Sem erros sintáticos, ou
- Erro léxico (indicar a linha do programa), ou
- Erro sintático (indicar a linha do programa).
