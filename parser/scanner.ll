%{

#include "scanner.hh"
#include <cstdlib>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef  YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

NUMBER [0-9]+

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
    yylval = lval;
%}
fin return token::END;


"+"            return '+';
"*"            return '*';
"-"            return '-';
"/"            return '/';
"("            return '(';
")"            return ')';
"="            return '=';
(?i:carre)     return token::CARRE;
(?i:rectangle) return token::RECTANGLE;
(?i:triangle)  return token::TRIANGLE;
(?i:cercle)    return token::CERCLE;
(?i:ellipse)   return token::ELLIPSE;
(?i:ligne)     return token::LIGNE;
(?i:chemin)    return token::CHEMIN;
(?i:texte)     return token::TEXTE;


[0-9]+      {
    yylval->build<int>(std::atoi(YYText()));
    return token::NUMBER;
}

"\n"          {
    loc->lines();
    return token::NL;
}

%%
