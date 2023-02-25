
%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string>
   #include <map>
   #include <iostream>
   #include <vector>
   #include <algorithm>
   void yyerror(const char *s);
   using namespace std;
   
 

%}


decimalintegerliteral (?:0|[1-9](?:_*[0-9])*)[lL]?
hexadecimalintegerliteral 0x[a-fA-F0-9](?:_*[a-fA-F0-9])*[lL]?
octalintegerliteral  0[0-7](?:_*[0-7])*[lL]?
binaryintegerliteral 0[bB][01](?:_*[01])*[lL]?
decimalfloatingpointliteral [+-]?(?:_*[0-9])+[.]?(?:_*[0-9])*([e][+-]?(?:_*[0-9])+)?[fF]?
hexadecimalfloatingpointliteral 0x(?:_*[a-fA-F0-9])+[.]?(?:_*[a-fA-F0-9])+([pP][+-]?(?:_*[a-fA-F0-9])+)?[fF]?
ws [ \t\f]
string (\"[^\n"]*\")
character (\'[.^\n]\')
comment ("//"(.*))


%%
"abstract" {return Abstract; }
"continue" {return Continue;}
"for" {return For;}
"new" {return New;}
"switch" {return Switch;}
"assert" {return Assert;}
"default" {return Default;} 
"if" {return If;}
"package" {return Package;}
"synchronized" {return Synchronized;}
"boolean" {return Boolean;}
"do" {return Do;}
"goto" {return Goto;}
"private" {return Private;}
"this" {return This;}
"break" {return Break;}
"double" {return Double;}
"implements" {return Implements;}   
"protected" {return Protected;}
"throw" {return throw;}
"byte" {return byte;}
"else" {return else;}
"import" {return Import;}    
"public" {return Public;}
"throws" {return Throws;}
"case" {return Case;}
"enum" {return Enum;}
"instanceof" {return Instanceof;}
"return" {return Return;}
"transient" {return Transient;}
"catch" {return Catch;}
"extends" {return Extends;}
"int" {return Integer;}
"short" {return Short;}
"try" {return Try;}
"char" {return Char;}
"final" {return Final;}
"interface" {return Interface;}
"static" {return Static;}
"void" {return Void;}
"class" {return Class;}
"finally" {return Finally;}
"long" {return Long;}
"strictfp" {return Strictfp;}
"volatile" {return Volatile;}
"const" {return Const;}
"float" {return Float;}
"native" {return Native;}
"super" {return Super;}
"while" {return While;}
"_" {return Underscore;}
"exports" {return Exports;}
"opens" {return Opens;}
"requires" {return Requires;}
"uses" {return Uses;}
"module" {return Module;}
"permits" {return Permits;}
"sealed" {return Sealed;}
"var" {return Var;}
"non-sealed" {return Non-sealed;}
"provides" {return Provides;}
"to" {return To;}
"with" {return With;}
"open" {return Open;}
"record" {return Record;}
"transitive" {return Transitive;}
"yield" {return Yield;}
"true" {return True;}
"false" {return False;}
"System.out.println" {  return Println; }
"length" {  return ArrayLength; }  
"main"  {  return Main; }
"String" {  return String; }


\n {yylineno++;}
[ \t\r]  {  }

{ws} {;}

"=" {return '=';}
">" {return '>';}
"<" {return '<'; }
"!" {return '!';}
"~" {return '~';}
"?" {return '?';}
":" {return ':';}
"->" {return '->';}
"==" {return '==';}
">=" {return '>=';}
"<=" {return '<=';}
"!=" {return '!=';}
"&&" {return And;}
"||" {return '||';}
"++" {return '++';}
"--" {return '--';}
"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}
"&" {return '&';}
"|" {return '|';}
"^" {return '^';}
"%" {return '%';}
"<<" {return '<<';}
">>" {return '>>';}
">>>" {return '>>>';}
"+=" {return '+=';}
"-=" {return '-=';}
"*=" {return '*=';}
"/=" {return '/=';}
"&=" {return '&=';}
"|=" {return '|=';}
"^=" {return '^=';}
"%=" {return '%=';}
"<<=" {return '<<=';}
">>=" {return '>>=';}
">>>=" {return '>>>=';} 
  
"("  {  return '(' ;}
")"  {  return ')' ;}
"{"  {return '{';} 
"}"  {return '}';}
"["  {return ']';}
"]"  {return ']';}
";"  {return ';';} 
","  {return ',';}
"."   {return '.';}
"..." {return '...';}   
"@"  {return '@';}  
"::" {return '::';} 

{comment} {;}

"/*"    {
        int c;

        while((c = yyinput()) != 0)
            {
            if(c == '\n')
                ++line_no;

            else if(c == '*')
                {
                if((c = yyinput()) == '/')
                    break;
                else
                    unput(c);
                }
            }
        }




({string})  {return String;}

{decimalintegerliteral}|{hexadecimalintegerliteral}|{octalintegerliteral}|{binaryintegerliteral}   {return Integerliteral;}


{decimalfloatingpointliteral}|{hexadecimalfloatingpointliteral}   {return Floatingliteral;}
  

{character} {return Character;}

([_][a-zA-Z0-9_$]+|[a-zA-Z$][a-zA-Z0-9_$]*) {return Id;}

"//".*"\n"      { yylineno++; }
"/*"(.|"\n")*"*\\"    { yylineno++; }
.  { yyerror("Unknown character"); };

%%

int yywrap() {
    return(1);
}

void yyerror(const char *s) {
    /*fflush(stdout);*/
    /*printf("\n%*s\n%*s\n", column, "*", column, s);*/
    //fprintf(stderr, "lexical error on line %d: %s\n", yylineno, s);
    char sr[100];
    sprintf(sr,"line %d %s\n", yylineno, s);
    throw logic_error(sr);
}



