
%{
   #include <stdio.h>
   #include <stdlib.h>
   #include <string>
   #include <map>
   #include <iostream>
   #include <vector>
   #include <algorithm>
    
 using namespace std;
   
  std::map<std::string,int> mp;
  std::map<std::string,std::string> mp1;
  std::vector<string> v;
  int line_no=1;


%}

letter [a-zA-z]
digit [0-9]
decimalintegerliteral (?:0|[1-9](?:_*[0-9])*)[lL]?
hexadecimalintegerliteral 0x[a-fA-F0-9](?:_*[a-fA-F0-9])*[lL]?
octalintegerliteral  0[0-7](?:_*[0-7])*[lL]?
binaryintegerliteral 0[bB][01](?:_*[01])*[lL]?
decimalfloatingpointliteral [+-]?(?:_*[0-9])+[.]?(?:_*[0-9])*([e][+-]?(?:_*[0-9])+)?[fF]?
hexadecimalfloatingpointliteral 0x(?:_*[a-fA-F0-9])+[.]?(?:_*[a-fA-F0-9])+([pP][+-]?(?:_*[a-fA-F0-9])+)?[fF]?
bool "true"|"false"
ws [ \t\f]
string (\"[^\n"]*\")
character (\'[.^\n]\')
comment ("//"(.*))
textblock (\"\"\"[^\n"]*\"\"\")

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
"import" |     
"public" |   
"throws" |
"case" |   
"enum" |  
"instanceof" |   
"return" |
"transient" |
"catch" |
"extends" |
"int" | 
"short" |
"try" |
"char" |      
"final" |     
"interface" |   
"static" | 
"void" |
"class" |     
"finally" |    
"long" |        
"strictfp" |  
"volatile" |
"const" | 
"float" |
"native" | 
"super" |
"while" |
"_" |
"exports" |
"opens" |
"requires" |  
"uses" |
"module" |       
"permits" |   
"sealed" |    
"var" |
"non-sealed" |   
"provides" |
"to" | 
"with" |
"open" |      
"record" |   
"transitive" |
"yield" { mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Keyword"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}
  
\n {line_no++;}

{ws} {;}

"="|">"|"<"|"!"|"~"|"?"|":"|"->"|"=="|">="|"<="|"!="|"&&"|"||"|"++"|"--"|"+"|"-"|"*"|"/"|"&"|"|"|"^"|"%"|"<<"|">>"|">>>"|"+="|"-="|"*="|"/="|"&="|"|="|"^="|"%="|"<<="|">>="|">>>=" { mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Operator"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

"(" |
")" |
"{" | 
"}" | 
"[" | 
"]" | 
";" |  
"," | 
"." |  
"..." |   
"@" |   
"::"  {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Separator"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }syntax tree with graphviz.
}

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

{bool} {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

"null" {mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

({string})  {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext," Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

{decimalintegerliteral}|{hexadecimalintegerliteral}|{octalintegerliteral}|{binaryintegerliteral}   {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

{decimalfloatingpointliteral}|{hexadecimalfloatingpointliteral}   {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

{character} {   mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Literal"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

([_][a-zA-Z0-9_$]+|[a-zA-Z$][a-zA-Z0-9_$]*) {
    mp[yytext]++; 
  mp1.insert(pair<string,string>(yytext,"Identifier"));
  std::vector<string>::iterator it = std::find(v.begin(),v.end(),yytext);
  if(it == v.end()){
    v.push_back(yytext);
  }
}

. {printf("illegal character : %s at %d \n", yytext,line_no);}

%%

int yywrap() {
    return(1);
}

int main() {

    yylex();

   FILE* fp = fopen("javaoutput.csv","a+");
   
if (!fp) {
        
        printf("Can't open file\n");
        return 0;
    }
    fprintf(fp,"Lexeme,Token,Count \n");

    for(auto i :v ){
      fprintf(fp,"%s, %s, %d \n",i.c_str(),mp1[i].c_str(),mp[i]);
    }

  fclose(fp);

}
