%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include <iostream>
#include <string>
#include <list>

using namespace std;

extern char yytext[];
extern int column;
extern int yylineno;
int cnt;

int yylex(void);
void yyerror(const char *s);

%}

%token 




%%

Start:
       MainClass ClassDeclarations      {}
       ;
MainClass:
       Class Identifier '{' Public Static Void Main '(' String '[' ']' Identifier ')' '{' Statement '}' '}'    { }
    ;
ClassDeclarations:
       ClassDeclaration ClassDeclarations{}
    |  {}
    ;
ClassDeclaration:
       Class Identifier'{' VarDeclarations MethodDeclarations '}' {}
    |  Class Identifier'{' MethodDeclarations '}' {}
    |  Class Identifier Extends Identifier '{' VarDeclarations MethodDeclarations '}'  {/* see extend from manu */}
    |  Class Identifier Extends Identifier '{' MethodDeclarations '}' {}
    ;

VarDeclarations:
        VarDeclaration {}
    |   VarDeclarations VarDeclaration {}
    ;

VarDeclaration:
        Type Identifier ';' {}
    ;

MethodDeclarations:
        MethodDeclaration MethodDeclarations {}
    | {}
    ;
MethodDeclaration:
        AccessModifier Type Identifier '(' Arguments ')' '{' VarDeclarations Statements Return Expression ';' '}' {}
    |   AccessModifier Type Identifier '(' Arguments ')' '{' Statements Return Expression ';' '}' {}
    ;

Arguments:
        Type Identifier {}
    |   Type Identifier ',' Arguments {}
    |   {}
    ;
Type:
        Primitive {}
    |   NonPrimitive{}
    ;
Primitive:
        Integer {}
    |   Boolean {}
    |   Long {}
    |   Float {}
    |   Double{}
    ;
NonPrimitive:
        Primitive Identifier '[' ']' {}
    |   Primitive Identifier '[' ']''['']' {}    
    |   Primitive Identifier '[' ']''['']''['']' {}
    ;
Statements:
        Statement Statements {}
    |   {}
    ;
Statement:
        '{' Statements '}' {}
    |   If '(' Expression ')' Statement Else Statement {}
    |   While '(' Expression ')' Statement {}
    |   For '(' Expression ';' Expression ';' Expression ')' {}   
    |   Println '(' PrintExpression ')' {}
    |   Identifier '=' Expression ';' {}
    |   Identifier '[' Expression ']' '=' Expression ';' {}
    ;
Expressions:
        Expression {}
    |   Expression ',' Expressions {}
    |   {}
    ;
Expression:
        AssignmentExpression
    ;
AssignmentExpression:
        ConditionalExpression
    |   Assignment
    ;
Assignment:
        Expression AssignmentOperator Expression
    ;
AssignmentOperator: 
        '='
    |   '*='
    |   '/='
    |   '-='
    |   '&='
    |   '+='
    ;

ConditionalExpression: 
        ConditionalOrExpression
    |   ConditionalOrExpression '?' Expression:ConditionalExpression
    ;
ConditionalOrExpression:
        ConditionalAndExpression
    |   ConditionalOrExpression '||' ConditionalAndExpression
    ;
ConditionalAndExpression:
        InclusiveOrExpression
    |   ConditionalAndExpression '&&' InclusiveOrExpression
    ;
InclusiveOrExpression:
        ExclusiveOrExpression
    |   InclusiveOrExpression '|' ExclusiveOrExpression
    ;
ExclusiveOrExpression:
        AndExpression 
    |   ExclusiveOrExpression '^' AndExpression
    ;
AndExpression:
        EqualityExpression
    |   AndExpression '&' EqualityExpression
    ;
EqualityExpression:
        RelationalExpression
    |   EqualityExpression '==' RelationalExpression
    |   EqualityExpression '!=' RelationalExpression
    ;
RelationalExpression:
        ShiftExpression
    |   RelationalExpression '<' ShiftExpression
    |   RelationalExpression '>' ShiftExpression
    |   RelationalExpression '<=' ShiftExpression
    |   RelationalExpression '>=' ShiftExpression
    ;
ShiftExpression:
        AdditiveExpression
    |   ShiftExpression '<<' AdditiveExpression
    |   ShiftExpression '>>' AdditiveExpression
    |   ShiftExpression '>>>' AdditiveExpression
    ;
AdditiveExpression:
        MultiplicativeExpression
    |   AdditiveExpression '+' MultiplicativeExpression
    |   AdditiveExpression '-' MultiplicativeExpression
    ;
MultiplicativeExpression:
        UnaryExpression
    |   MultiplicativeExpression '*' UnaryExpression
    |   MultiplicativeExpression '/' UnaryExpression
    |   MultiplicativeExpression '%' UnaryExpression
    ;
UnaryExpression:    
        PreIncrementExpression
    |   PreDecrementExpression
    |   '+' UnaryExpression
    |   '-' UnaryExpression
    |   UnaryExpressionNotPlusMinus  
    ;
PreIncrementExpression:
        '++' UnaryExpression
    ;
PreDecrementExpression:
        '--' UnaryExpression
    ;
UnaryExpressionNotPlusMinus:
        PostfixExpression
    |   '~' UnaryExpression
    |   '!' UnaryExpression
    ;
PostfixExpression:
        Primary      
    |   ExpressionName
    |   PostIncrementExpression
    |   PostDecrementExpression
    ;
PostIncrementExpression:
        PostfixExpression '++'
    ;
PostDecrementExpression:
        PostfixExpression '--'
    ;                                         


                                

Identifier:
        id {}
        ;
%%

int main(void) {
    yyparse();
    return 0;
}