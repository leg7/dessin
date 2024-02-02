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


"+"               return '+';
"*"               return '*';
"-"               return '-';
"/"               return '/';
"("               return '(';
")"               return ')';
"="               return '=';

(?i:carre)        return token::CARRE;
(?i:rectangle)    return token::RECTANGLE;
(?i:triangle)     return token::TRIANGLE;
(?i:cercle)       return token::CERCLE;
(?i:ellipse)      return token::ELLIPSE;
(?i:ligne)        return token::LIGNE;
(?i:chemin)       return token::CHEMIN;
(?i:texte)        return token::TEXTE;
","               return ',';

":"               return ':';
"&"               return '&';
";"               return ';';
"->"              return token::FLECHE;
"{"               return '{';
"}"               return '}';

"rouge" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Rouge);
    return token::CONSTANTE_COULEUR;
}
"vert" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Vert);
    return token::CONSTANTE_COULEUR;
}
"bleu" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Bleu);
    return token::CONSTANTE_COULEUR;
}
"jaune" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Jaune);
    return token::CONSTANTE_COULEUR;
}
"orange" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Orange);
    return token::CONSTANTE_COULEUR;
}
"violet" { yylval->build<Couleur::Nom>(Couleur::Nom::Violet);
    return token::CONSTANTE_COULEUR;
}
"magenta" { yylval->build<Couleur::Nom>(Couleur::Nom::Magenta);
    return token::CONSTANTE_COULEUR;
}
"cyan" { yylval->build<Couleur::Nom>(Couleur::Nom::Cyan);
    return token::CONSTANTE_COULEUR;
}
"blanc" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Blanc);
    return token::CONSTANTE_COULEUR;
}
"noir" {
    yylval->build<Couleur::Nom>(Couleur::Nom::Noir);
    return token::CONSTANTE_COULEUR;
}

"\"[[:alpha:]]\"" {
    yylval->build<const char*>(YYText());
    return token::STRING;
}

[0-9]+      {
    yylval->build<int>(std::atoi(YYText()));
    return token::NUMBER;
}

"\n"          {
    loc->lines();
    return token::NL;
}

%%
