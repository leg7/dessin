%{
#include "scanner.hh"
#include <cstdlib>
#include <string>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef	YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

NUMBER [0-9]+
HEX "#"[0-9A-Fa-f]{6}
COMPOSANTE_COULEUR 25[0-5] | 2[0-4][0-9] | 1[0-9][0-9] | [1-9]?[0-9]

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
	yylval = lval;
%}
fin return token::END;


"+"				 return '+';
"*"				 return '*';
"-"				 return '-';
"/"				 return '/';
"("				 return '(';
")"				 return ')';
"="				 return '=';

(?i:carre)		         return token::CARRE;
(?i:rectangle)	                 return token::RECTANGLE;
(?i:triangle)	                 return token::TRIANGLE;
(?i:cercle)		         return token::CERCLE;
(?i:ellipse)	                 return token::ELLIPSE;
(?i:ligne)		         return token::LIGNE;
(?i:chemin)		         return token::CHEMIN;
(?i:texte)		         return token::TEXTE;
","				 return ',';

":"				 return ':';
"&"				 return '&';
";"				 return ';';
"->"			         return token::FLECHE;
"{"				 return '{';
"}"				 return '}';


"couleur" return token::KW_COULEUR;
"rotation" return token::KW_ROTATION;
"remplissage" return token::KW_REMPLISSAGE;
"opacite" return token::KW_OPACITE;
"epaisseur" return token::KW_EPAISSEUR;

"rouge" {
	yylval->build<std::string>("red");
	return token::COULEUR;
}
"vert" {
	yylval->build<std::string>("green");
	return token::COULEUR;
}
"bleu" {
	yylval->build<std::string>("blue");
	return token::COULEUR;
}
"jaune" {
	yylval->build<std::string>("yellow");
	return token::COULEUR;
}
"violet" { yylval->build<std::string>("purple");
	return token::COULEUR;
}
"blanc" {
	yylval->build<std::string>("white");
	return token::COULEUR;
}
"noir" {
	yylval->build<std::string>("black");
	return token::COULEUR;
}
"orange"|"magenta"|"cyan" {
	yylval->build<std::string>(YYText());
	return token::COULEUR;
}

"\"[[:alpha:]]\"" {
	yylval->build<const char*>(YYText());
	return token::STRING;
}

"rgb(" {COMPOSANTE_COULEUR} "," {COMPOSANTE_COULEUR} "," {COMPOSANTE_COULEUR} ")" {
	yylval->build<std::string>(YYText());
	return token::COULEUR;
}

{HEX} {
	yylval->build<std::string>(YYText);
	return token::COULEUR;
}

{NUMBER}? "." {NUMBER} {
	yylval->build<float>(std::stof(YYText()));
	return token::REEL;
}

{NUMBER} {
	yylval->build<int>(std::atoi(YYText()));
	return token::ENTIER;
}

[A-Za-z_][A-Za-z_0-9]* {
    yylval->build<const char*>(YYText());
    return token::IDENTIFIANT;
}


"\n" {
	loc->lines();
	return token::NL;
}

%%
